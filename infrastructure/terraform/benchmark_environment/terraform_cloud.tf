terraform {
  required_version = ">= 1.2.5"
  cloud {
    organization = "Piotr_Rogowski"

    workspaces {
      name = "gh-actions"
    }
  }
}
