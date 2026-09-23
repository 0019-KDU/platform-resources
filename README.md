# platform-resources

Self-service cloud resources for the DevOps94 IDP. **Do not edit by hand**: request
resources from Backstage (Create → "PostgreSQL database", "S3 bucket", "EC2 instance").

| Step | What happens |
|---|---|
| Request in Backstage | A pull request adds `resources/<type>/<name>/` (Terraform using a vetted module + `catalog-info.yaml`) |
| Pull request | `terraform plan` runs with a **read-only** role and is posted as a comment |
| Review + merge | Platform team approves; `terraform apply` runs with the apply role (only `devops94-idp-res-*` resources) |
| Catalog | The resource appears in Backstage (kind `Resource`) with owner and links |
| Decommission | Add a `DESTROY` file in the resource folder via PR; merge runs `terraform destroy` |

Modules: [idp-platform/infra/modules](https://github.com/0019-KDU/idp-platform/tree/main/infra/modules)
(`rds-postgres`, `s3-bucket`, `ec2-instance`).
