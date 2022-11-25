//rohit-bucket-tf bucket creation 


resource "aws_s3_bucket" "del" {
  bucket = "rohit-bucket-tf"

  tags = {
    Name = "My bucket"
  }
}


//public bucket 

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.del.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// s3 sync we always have to push complete project for the webhosting 

resource "null_resource" "remove_and_upload_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync ${path.module}/html s3://${aws_s3_bucket.del.id}"
  }
}