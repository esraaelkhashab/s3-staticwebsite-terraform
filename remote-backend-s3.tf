
terraform {
  backend "s3" {
    #layer-buckett "terraform_locks
    bucket         = "mfralabdes213" #"layer-buckett"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_locks_table"
  }
}