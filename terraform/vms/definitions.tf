locals {
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
      storage   = "ssd"
      node      = "epsilon"
      template  = "debian11-template"
    },
    {
      ip        = "192.168.1.11"
      cores     = 4
      memory    = 8192
      disk_size = "40G"
      storage   = "ssd"
      node      = "epsilon"
      template  = "debian11-template"
    },
    {
      ip        = "192.168.1.12"
      cores     = 4
      memory    = 4096
      disk_size = "40G"
      storage   = "local-lvm"
      node      = "delta"
      template  = "debian11-template"
    }
  ]

  vm_def_worker = [
    {
      ip        = "192.168.1.20"
      cores     = 4
      memory    = 8192
      disk_size = "40G"
      storage   = "ssd"
      node      = "epsilon"
      template  = "debian11-template"
    },
    {
      ip        = "192.168.1.21"
      cores     = 2
      memory    = 8192
      disk_size = "40G"
      storage   = "ssd"
      node      = "epsilon"
      template  = "debian11-template"
    },
    {
      ip        = "192.168.1.22"
      cores     = 4
      memory    = 4096
      disk_size = "40G"
      storage   = "local-lvm"
      node      = "delta"
      template  = "debian11-template"
    },
    {
      ip        = "192.168.1.23"
      cores     = 4
      memory    = 4096
      disk_size = "40G"
      storage   = "local-lvm"
      node      = "delta"
      template  = "debian11-template"
    }
  ]
}
