locals {
  cluster_name         = "prod"
  network_gateway      = "192.168.0.1"
  network_subnet_range = "23"
  vm_starting_vmid     = 500
  ssh_public_keys      = split("\n", data.http.github_keys.response_body)

  vm_definition = [
    {
      type        = "master"
      ip          = "192.168.1.10"
      cores       = 4
      memory      = 16384
      disk_size   = 80
      storage     = "nvme-ssd"
      storage_ssd = true
      node        = "epsilon"
      template    = 9000
    },
    {
      type        = "master"
      ip          = "192.168.1.11"
      cores       = 4
      memory      = 8192
      disk_size   = 80
      storage     = "nvme-ssd"
      storage_ssd = true
      node        = "epsilon"
      template    = 9000
    },
    {
      type        = "master"
      ip          = "192.168.1.12"
      cores       = 4
      memory      = 8192
      disk_size   = 80
      storage     = "nvme-ssd"
      storage_ssd = true
      node        = "delta"
      template    = 9001
    },
    {
      type        = "worker"
      ip          = "192.168.1.20"
      cores       = 4
      memory      = 16384
      disk_size   = 80
      storage     = "nvme-ssd"
      storage_ssd = true
      node        = "epsilon"
      template    = 9000
    },
    {
      type        = "worker"
      ip          = "192.168.1.21"
      cores       = 4
      memory      = 16384
      disk_size   = 80
      storage     = "nvme-ssd"
      storage_ssd = true
      node        = "epsilon"
      template    = 9000
    },
    {
      type        = "worker"
      ip          = "192.168.1.22"
      cores       = 4
      memory      = 8192
      disk_size   = 80
      storage     = "nvme-ssd"
      storage_ssd = true
      node        = "delta"
      template    = 9001
    },
    {
      type        = "worker"
      ip          = "192.168.1.23"
      cores       = 4
      memory      = 8192
      disk_size   = 80
      storage     = "nvme-ssd"
      storage_ssd = true
      node        = "delta"
      template    = 9001
    }
  ]
}
