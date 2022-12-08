locals {
  proxmox_target_node     = "epsilon"
  template_name           = "ubuntu-2204-template"
  network_gateway         = "192.168.0.1"
  vm_master_starting_vmid = 500
  vm_worker_starting_vmid = 550

  vm_def_master = [
    {
      ip     = "192.168.1.10"
      cores  = 2
      memory = 2048
    },
    {
      ip     = "192.168.1.11"
      cores  = 2
      memory = 2048
    },
    {
      ip     = "192.168.1.12"
      cores  = 2
      memory = 2048
    }
  ]

  vm_def_worker = [
    {
      ip     = "192.168.1.20"
      cores  = 2
      memory = 2048
    },
    {
      ip     = "192.168.1.21"
      cores  = 2
      memory = 2048
    }
  ]
}
