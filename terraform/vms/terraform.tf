terraform {
  cloud {
    organization = "georgev"

    workspaces {
      name = "home-cluster"
    }
  }

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.21.0"
    }

    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.3.0"
    }
  }
}
