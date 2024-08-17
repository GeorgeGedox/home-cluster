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
      version = "0.22.0"
    }

    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }
  }
}
