output "bucket_url" {
  
   #value = aws_s3_bucket.static-hosting-bucket.website_endpoint
   
   value = "http://${aws_s3_bucket.static-hosting-bucket.id}.s3-website.us-east-1.amazonaws.com"
}