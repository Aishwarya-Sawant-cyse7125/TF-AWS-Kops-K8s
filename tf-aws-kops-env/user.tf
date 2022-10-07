resource "aws_iam_user" "user" {
  name       = "kops"
}

resource "aws_iam_access_key" "access_key" {
  user       = aws_iam_user.user.name
  depends_on = [aws_iam_user.user]
}