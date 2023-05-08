terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "hoanlac"

    workspaces {
      name = "homework"
    }
  }
}