terraform {
  required_version = ">= 1.2.5"
  cloud {
    organization = "Projekt-badawczy"

    workspaces {
      name = "gh-actions"
    }
  }
}
