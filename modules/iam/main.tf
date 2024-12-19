resource "aws_iam_role" "cloudfront_role" {
  name = "${var.project_name}-cloudfront-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_access_policy" {
  name = "${var.project_name}-cloudfront-s3-access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = ["arn:aws:s3:::kloud-webpage/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudfront_role_attach" {
  role       = aws_iam_role.cloudfront_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

