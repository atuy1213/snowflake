resource "aws_s3_bucket" "adlog" {
  bucket = "${var.environment}-${var.project}-adlog"
}

resource "aws_s3_bucket_versioning" "adlog" {
  bucket = aws_s3_bucket.adlog.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "adlog" {
  bucket                  = aws_s3_bucket.adlog.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "adlog" {
  bucket = aws_s3_bucket.adlog.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" // SSE by S3
    }
  }
}
