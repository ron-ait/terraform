resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.del.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}  