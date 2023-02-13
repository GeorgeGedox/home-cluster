locals {
  proxmox_target_node     = "epsilon"
  template_name           = "debian-11-template"
  network_gateway         = "192.168.0.1"
  network_subnet_range    = "23"
  vm_master_starting_vmid = 500
  vm_worker_starting_vmid = 550

  vm_def_master = [
    {
      ip        = "192.168.1.10"
      cores     = 2
      memory    = 8192
      disk_size = "40G"
    },
    {
      ip        = "192.168.1.11"
      cores     = 4
      memory    = 8192
      disk_size = "40G"
    },
    {
      ip        = "192.168.1.12"
      cores     = 2
      memory    = 8192
      disk_size = "40G"
    }
  ]

  vm_def_worker = [
    {
      ip        = "192.168.1.20"
      cores     = 4
      memory    = 8192
      disk_size = "40G"
    },
    {
      ip        = "192.168.1.21"
      cores     = 2
      memory    = 8192
      disk_size = "40G"
    }
  ]
}
