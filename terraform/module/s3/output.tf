output "s3_adlog_bucket_arn" {
  value = aws_s3_bucket.adlog.arn
}

output "s3_adlog_bucket_name" {
  value = aws_s3_bucket.adlog.bucket
}
