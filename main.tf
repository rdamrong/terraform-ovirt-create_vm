variable "ovirt_password" {
   type = string
   description = "oVirt Admin Password"

}

provider "ovirt" {
   username = "admin@internal"
   url = "https://ovirt.example.com/ovirt-engine/api"
   password = var.ovirt_password
}

resource "ovirt_vm" "vm" {
  name = "my_centos"
  cluster_id = "c6c4902a-5721-11ea-983e-00163e58725a"
  template_id = "1cb7777c-6b13-4e5d-87a5-b06f716a64bd"
  initialization {
    authorized_ssh_key = file(pathexpand("~/.ssh/id_rsa.pub"))
    host_name = "drs_centos"
    timezone = "Asia/Bangkok"
    user_name = "root"
#    nic_configuration {
#      label              = "eth0" 
#      boot_proto         = "static"
#      address            = "192.168.254.220"
#      gateway            = "192.168.254.254"
#      netmask            = "255.255.255.0"
#      on_boot            = true
#    }
#    dns_search = "example.com"
#    dns_servers = "192.168.254.254"

    nic_configuration {
       label = "eth0"
       boot_proto = "dhcp"
       on_boot = true
    }
  }
}

#data "ovirt_vms" "vmdata" {
#  name_regex = ovirt_vm.vm.name
#}
#output "vm_status" {
#   value = data.ovirt_vms.vmdata.id
#}
