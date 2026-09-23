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
    key          = "resources/rds-postgres/orders-db/terraform.tfstate"
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
      stack      = "resource-rds-postgres-orders-db"
      managed-by = "terraform"
    }
  }
}

module "this" {
  source               = "git::https://github.com/0019-KDU/idp-platform.git//infra/modules/rds-postgres?ref=main"
  name                 = "orders-db"
  instance_class       = "db.t4g.micro"
  allocated_storage_gb = 20
  tags = {
    owner        = "group:default/platform-admins"
    component    = "component:default/orders-api"
    requested-by = ""
  }
}

output "endpoint" { value = module.this.endpoint }
output "port" { value = module.this.port }
output "database_name" { value = module.this.database_name }
output "username" { value = module.this.username }
output "master_user_secret_arn" { value = module.this.master_user_secret_arn }
output "console_url" { value = module.this.console_url }
