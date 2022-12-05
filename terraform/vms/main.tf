terraform {
  cloud {
    organization = "georgev"

    workspaces {
      name = "home-cluster"
    }
  }

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "~> 2.9.11"
    }

    sops = {
      source  = "carlpett/sops"
      version = "0.7.1"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
  }
}

data "sops_file" "vms_secrets" {
  source_file = "secrets.sops.yaml"
}

data "http" "github_keys" {
  url = "https://github.com/georgegedox.keys"
}

provider "proxmox" {
  pm_api_url          = data.sops_file.vms_secrets.data["proxmox_api_url"]
  pm_api_token_id     = data.sops_file.vms_secrets.data["proxmox_api_id"]
  pm_api_token_secret = data.sops_file.vms_secrets.data["proxmox_api_token"]
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "cluster_master" {
  count       = 3
  vmid        = 500 + count.index
  name        = "cluster-master-${count.index + 1}"
  target_node = "epsilon"
  clone       = "ubuntu-2204-template"

  agent     = 1
  os_type   = "cloud-init"
  cores     = 2
  sockets   = 1
  cpu       = "host"
  memory    = 2048
  ipconfig0 = "ip=192.168.0.21${count.index}/8,gw=192.168.0.1"
  onboot    = true

  ciuser  = data.sops_file.vms_secrets.data["vm_cloudinit_user"]
  sshkeys = chomp(data.http.github_keys.response_body)

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  disk {
    storage = "ssd"
    size    = "32G"
    type    = "scsi"
    ssd     = 1
    discard = "on"
  }
}

resource "proxmox_vm_qemu" "cluster_worker" {
  count       = 2
  vmid        = 510 + count.index
  name        = "cluster-worker-${count.index + 1}"
  target_node = "epsilon"
  clone       = "ubuntu-2204-template"

  agent     = 1
  os_type   = "cloud-init"
  cores     = 2
  sockets   = 1
  cpu       = "host"
  memory    = 2048
  ipconfig0 = "ip=192.168.0.22${count.index}/8,gw=192.168.0.1"
  onboot    = true

  ciuser  = data.sops_file.vms_secrets.data["vm_cloudinit_user"]
  sshkeys = chomp(data.http.github_keys.response_body)

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  disk {
    storage = "ssd"
    size    = "32G"
    type    = "scsi"
    ssd     = 1
    discard = "on"
  }
}
