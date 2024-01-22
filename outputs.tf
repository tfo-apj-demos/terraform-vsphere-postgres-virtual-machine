output "virtual_machine_id" {
  description = "The ID of the virtual machine."
  value       = module.vm.virtual_machine_id
}

output "vsphere_compute_cluster_id" {
  description = "The ID of the vSphere compute cluster where the VM is deployed."
  value       = module.vm.vsphere_compute_cluster_id
}

output "virtual_machine" {
  value = tomap({
    for k, v in module.vm : k => v {
      id = v.virtual_machine_id
      virtual_machine_name = v.virtual_machine_name
      ip_address = v.ip_address
    }
  })
}

/*output "virtual_machine_name" {
  description = "The name of the virtual machine."
  value       = module.vm.virtual_machine_name
}

output "ip_address" {
  description = "The default IP address of the virtual machine."
  value       = module.vm.ip_address
}*/
