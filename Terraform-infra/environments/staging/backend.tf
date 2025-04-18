# terraform {
#   backend "s3" {
#     bucket         = "open-tele-proj-staging-state-locking"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "open-tele-proj-staging-state-locking"
#     encrypt        = true
#   }
# }
