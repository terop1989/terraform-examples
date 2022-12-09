resource "proxmox_vm_qemu" "vm" {
  count             = 3
  desc              = "Test Deploy VM"
  name              = "k8s-0${count.index + 1}"
  target_node       = var.prx_node
  cores             = 2
  sockets           = 2
  memory            = 4096
  clone             = "ubuntu-18.04.5-LTS"
  scsihw            = "virtio-scsi-pci"
  boot              = "order=scsi0"
  os_type           = "cloud-init"
  ipconfig0         = "ip=${var.ip_subnet}.${var.ip_start_address + count.index + 1}/24,gw=${var.ip_subnet}.${var.ip_gateway_address}"
  nameserver        = var.dns_address
  searchdomain      = var.domain_name
  ciuser            = ""
  sshkeys           = var.ssh-key

  disk {
    size            = "50G"
    type            = "scsi"
    storage         = "proxmox-storage"
  }

  network {
    model           = "e1000"
    bridge          = "vmbr0"
    tag             = var.net_tag
  }
}