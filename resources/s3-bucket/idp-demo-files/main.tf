# Requested in Backstage by , owner group:default/platform-admins.
# Managed by the platform-resources pipeline: edit only via pull request.
terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = "devops94-idp-tfstate-697502032879"
    key          = "resources/s3-bucket/idp-demo-files/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      project    = "devops94-idp"
      stack      = "resource-s3-bucket-idp-demo-files"
      managed-by = "terraform"
    }
  }
}

module "this" {
  source     = "git::https://github.com/0019-KDU/idp-platform.git//infra/modules/s3-bucket?ref=main"
  name       = "idp-demo-files"
  versioning = true
  tags = {
    owner        = "group:default/platform-admins"
    component    = "component:default/orders-api"
    requested-by = ""
  }
}

output "bucket_name" { value = module.this.bucket_name }
output "bucket_arn" { value = module.this.bucket_arn }
output "console_url" { value = module.this.console_url }
