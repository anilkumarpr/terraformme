variable "resource_location" {
    default = "North Europe"
    description = "location"
}

variable web_disp_vm_names {
    type = list(string)
    description= "vm names"
    default=["web_disp1","web_disp2"]
}

variable qas_ascs_vm_names {
    type = list(string)
    description= "vm names"
    default=["ascs_vm1","ascs_vm2"]
}

variable qas_app_vm_names {
    type = list(string)
    description= "vm names"
    default=["ascs_vm1","ascs_vm2"]
}

variable qas_db_vm_names {
    type = list(string)
    description= "vm names"
    default=["db_vm1","db_vm2"]
}
