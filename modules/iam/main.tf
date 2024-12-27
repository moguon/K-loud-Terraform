# 기존 Lambda 역할
resource "aws_iam_role" "lambda_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

# AWS 관리형 정책 첨부 (AmazonS3FullAccess 등)
resource "aws_iam_role_policy_attachment" "attach_managed_policies" {
  for_each = toset(var.managed_policies)

  role       = aws_iam_role.lambda_role.name
  policy_arn = each.value
}

# 고객 관리형 정책 정의
resource "aws_iam_policy" "custom_lambda_policy_1" {
  name        = "AWSLambdaBasicExecutionRole-142fcf84"
  description = "Basic execution role for Lambda"
  policy      = file("${path.module}/policies/lambda_basic.json")
}

resource "aws_iam_policy" "custom_lambda_policy_2" {
  name        = "AWSLambdaTestHarnessExecutionRole-0bc..."
  description = "Test harness role for Lambda"
  policy      = file("${path.module}/policies/lambda_test.json")
}

# 고객 관리형 정책을 Lambda Role에 연결
resource "aws_iam_role_policy_attachment" "attach_custom_policies" {
  for_each = {
    lambda_basic = aws_iam_policy.custom_lambda_policy_1.arn
    lambda_test  = aws_iam_policy.custom_lambda_policy_2.arn
  }

  role       = aws_iam_role.lambda_role.name
  policy_arn = each.value
}