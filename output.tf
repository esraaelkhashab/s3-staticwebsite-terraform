output "bucket_url" {
  
   value = module.s3.bucket_url
   #aws_s3_bucket.static-hosting-bucket.website_endpoint
}

