resource "aws_iam_access_key" "akiay5rbxc44jba7765e" {
  status = "Active"
  user   = aws_iam_user.github_ci.id
}

resource "aws_iam_user" "github_ci" {
  name = "github-ci"
  path = "/"
}

