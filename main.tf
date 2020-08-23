variable "ovirt_password" {
   type = string
   description = "oVirt Admin Password"

}
variable "x" {
  type = number
  description = "oVirt Cluster ID"
  default =  50
}
variable "no_student" {
  type = number
  description = "Number of Student"
  default =  5
}
variable "vm_memory" {
  type = string
  description = "oVirt Cluster ID"
  default =  "2048"
}
variable "cluster_id" {
  type = string
  description = "oVirt Cluster ID"
  default =  "41cbc8c7-dc43-4b37-9478-8ddeee5b224b"
}
variable "template_id" {
  type = string
  description = "oVirt template ID"
  default =  "df237f70-6a3a-4d61-b913-df4176ad6c6c"
}


provider "ovirt" {
   username = "admin@internal"
   url = "https://ovirt.example.com/ovirt-engine/api"
   password = var.ovirt_password
}

resource "ovirt_vm" "lab" {
  count = var.no_student 
  name = format("%s%d","lab",  var.x+count.index )
  cluster_id = var.cluster_id
  template_id = var.template_id
  memory = var.vm_memory
  cores = "2"
  sockets = "1"
  initialization {
    authorized_ssh_key = file(pathexpand("~/.ssh/id_rsa.pub"))
    host_name = format("%s%d","lab",var.x+count.index)
    timezone = "Asia/Bangkok"
    user_name = "root"
    nic_configuration {
      label              = "eth0" 
      boot_proto         = "static"
      address            = format("%s%d", "192.168.254.",var.x+count.index)
      gateway            = "192.168.254.254"
      netmask            = "255.255.255.0"
      on_boot            = true
    }
    dns_search = "example.com"
    dns_servers = "192.168.254.254"
  }
}
resource "ovirt_vm" "kmaster" {
  count = var.no_student
  name = format("%s%d","kmaster",var.x+count.index)
  cluster_id = var.cluster_id
  template_id = var.template_id
  memory = var.vm_memory
  cores = "2"
  sockets = "1"
  initialization {
    authorized_ssh_key = file(pathexpand("~/.ssh/id_rsa.pub"))
    host_name = format("%s%d","kmaster",var.x+count.index)
    timezone = "Asia/Bangkok"
    user_name = "root"
    nic_configuration {
      label              = "eth0" 
      boot_proto         = "static"
      address            = format("%s%d", "192.168.254.",var.x+30+count.index)
      gateway            = "192.168.254.254"
      netmask            = "255.255.255.0"
      on_boot            = true
    }
    dns_search = "example.com"
    dns_servers = "192.168.254.254"
  }
}

resource "ovirt_vm" "kworker1" {
  count = var.no_student
  name = format("%s%d_1","kworker",var.x+count.index) 
  cluster_id = var.cluster_id
  template_id = var.template_id
  memory = var.vm_memory
  cores = "2"
  sockets = "1"
  initialization {
    authorized_ssh_key = file(pathexpand("~/.ssh/id_rsa.pub"))
    host_name = format("%s%d_1","kworker",var.x+count.index) 
    timezone = "Asia/Bangkok"
    user_name = "root"
    nic_configuration {
      label              = "eth0" 
      boot_proto         = "static"
      address            = format("%s%d", "192.168.254.",var.x+60+count.index)
      gateway            = "192.168.254.254"
      netmask            = "255.255.255.0"
      on_boot            = true
    }
    dns_search = "example.com"
    dns_servers = "192.168.254.254"
  }
}

resource "ovirt_vm" "kworker2" {
  count = var.no_student
  name = format("%s%d_2","kworker",var.x+count.index) 
  cluster_id = var.cluster_id
  template_id = var.template_id
  memory = var.vm_memory
  cores = "2"
  sockets = "1"
  initialization {
    authorized_ssh_key = file(pathexpand("~/.ssh/id_rsa.pub"))
    host_name = format("%s%d_2","kworker",var.x+count.index)
    timezone = "Asia/Bangkok"
    user_name = "root"
    nic_configuration {
      label              = "eth0" 
      boot_proto         = "static"
      address            = format("%s%d", "192.168.254.",var.x+90+count.index)
      gateway            = "192.168.254.254"
      netmask            = "255.255.255.0"
      on_boot            = true
    }
    dns_search = "example.com"
    dns_servers = "192.168.254.254"
#    nic_configuration {
#       label = "eth0"
#       boot_proto = "dhcp"
#       on_boot = true
#    }
  }
}

#data "ovirt_vms" "vmdata" {
#  name_regex = ovirt_vm.vm.name
#}
#output "vm_status" {
#   value = data.ovirt_vms.vmdata.id
#}
