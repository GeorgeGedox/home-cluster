data "sops_file" "vms_secrets" {
  source_file = "secrets.sops.yaml"
}

data "http" "github_keys" {
  url = "https://github.com/georgegedox.keys"
}

provider "proxmox" {
  endpoint  = data.sops_file.vms_secrets.data["proxmox_endpoint"]
  api_token = "${data.sops_file.vms_secrets.data["proxmox_user_id"]}=${data.sops_file.vms_secrets.data["proxmox_user_token"]}"
  insecure  = true
  ssh {
    agent    = true
    username = data.sops_file.vms_secrets.data["proxmox_ssh_user"]
    password = data.sops_file.vms_secrets.data["proxmox_ssh_password"]
  }
}

resource "proxmox_virtual_environment_vm" "cluster_vms" {
  for_each = { for vm in local.vm_definition : vm.ip => vm }

  name        = try(each.value.hostname, "${local.cluster_name}-${index(local.vm_definition, each.value)}-${each.value.type}")
  description = "Managed by Terraform"
  tags        = ["terraform", each.value.type, local.cluster_name, each.value.node]

  node_name = try(each.value.node, "")
  vm_id     = local.vm_starting_vmid + index(local.vm_definition, each.value)

  clone {
    datastore_id = try(each.value.storage, "local-lvm")
    retries      = 3
    vm_id        = each.value.template
  }

  cpu {
    type  = "host"
    cores = try(each.value.cores, 1)
  }

  memory {
    dedicated = try(each.value.memory, 1024)
  }

  // Only enable if template already has qemu agent installed,
  // otherwise the provider will timeout waiting for the vm to become online
  agent {
    enabled = true
  }

  disk {
    datastore_id = try(each.value.storage, "local-lvm")
    interface    = "scsi0"
    size         = try(each.value.disk_size, "10")
    discard      = each.value.storage_ssd ? "on" : "ignore"
    file_format  = "raw"
    ssd          = each.value.storage_ssd
  }

  initialization {
    datastore_id = try(each.value.storage, "local-lvm")

    ip_config {
      ipv4 {
        address = "${each.value.ip}/${local.network_subnet_range}"
        gateway = local.network_gateway
      }
    }

    user_account {
      username = data.sops_file.vms_secrets.data["vm_cloudinit_user"]
      keys     = slice(local.ssh_public_keys, 0, length(local.ssh_public_keys) - 1)
    }
  }
}
