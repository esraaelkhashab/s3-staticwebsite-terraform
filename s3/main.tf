#Creating s3
resource "aws_s3_bucket" "static-hosting-bucket" {
  
  bucket = var.bucket_name

  tags = {
    Environment = "Dev"
  }

}

#enable versioning
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.static-hosting-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


#add policy to bucket allow anonymous access bucket objects 
resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = aws_s3_bucket.static-hosting-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}




#disable block all public access 

resource "aws_s3_bucket_public_access_block" "change-public-access" {
  bucket = aws_s3_bucket.static-hosting-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#allow abjects on bucket to be read



#adding objects on bucket index

resource "aws_s3_bucket_object" "index-obj" {
  bucket = aws_s3_bucket.static-hosting-bucket.id
  key    = "index.html"
  source = "index.html"
  #acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "error-obj" {
  bucket = aws_s3_bucket.static-hosting-bucket.id
  key    = "error.html"
  source = "error.html"
  #acl = "public-read"
  content_type = "text/html"
}

#allow static websites
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.static-hosting-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [aws_s3_bucket.static-hosting-bucket]
}












