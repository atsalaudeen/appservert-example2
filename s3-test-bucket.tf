# create buckets or use existing ones
resource "aws_s3_bucket" "testapplblogs" {
  bucket = "testtestappalblogs"
  acl    = "private"

  tags = {
    Name        = "mytestappalblogs"
    Environment = "Production"
  }
}

