resource "aws_s3_bucket" "jenkins_backup" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  lifecycle {
    prevent_destroy = false
  }
}