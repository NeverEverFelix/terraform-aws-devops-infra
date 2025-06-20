resource "aws_iam_policy" "ecr_inline_policy" {
  name   = "ecr-inline-policy"
  policy = file("${path.module}/ecr-inline-policy.json")
}

resource "aws_iam_policy" "ebs_csi_policy" {
  name   = "ebs-csi-policy"
  policy = file("${path.module}/ebs_csi_policy.json")
}
