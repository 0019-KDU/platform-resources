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
    key          = "resources/ec2-instance/demo-runner/terraform.tfstate"
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
      stack      = "resource-ec2-instance-demo-runner"
      managed-by = "terraform"
    }
  }
}

module "this" {
  source         = "git::https://github.com/0019-KDU/idp-platform.git//infra/modules/ec2-instance?ref=main"
  name           = "demo-runner"
  instance_type  = "t3.micro"
  root_volume_gb = 20
  tags = {
    owner        = "group:default/platform-admins"
    component    = ""
    requested-by = ""
  }
}

output "instance_id" { value = module.this.instance_id }
output "private_ip" { value = module.this.private_ip }
output "session_manager_url" { value = module.this.session_manager_url }
output "console_url" { value = module.this.console_url }
