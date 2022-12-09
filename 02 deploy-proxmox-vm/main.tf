resource "proxmox_vm_qemu" "pre-koe-test-deploy-vm" {
  desc              = "Test Deploy VM"
  name              = "pre-koe-deploy-01"
  target_node       = var.prx_node
  cores             = 4
  sockets           = 1
  memory            = 4096
  balloon           = 2048
  # iso               = "local:iso/alt-sp8-server-20201202-x86_64.iso"
  clone             = "centos-7.9.2009-s"
  scsihw            = "virtio-scsi-pci"
  boot              = "order=scsi0"
  os_type           = "cloud-init"
  ipconfig0         = var.ip_conf
  nameserver        = "8.8.8.8"
  searchdomain      = "env.loc"
  ciuser            = ""
  sshkeys           = var.ssh-key

  disk {
    size            = "30G"
    type            = "scsi"
    storage         = "proxmox-storage"
  }

  network {
    model           = "e1000"
    bridge          = "vmbr0"
    tag             = var.net_tag
  }
}