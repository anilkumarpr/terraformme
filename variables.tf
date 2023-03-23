variable "resource_location" {
    default = "North Europe"
    description = "location"
}

variable web_disp_vm_names {
    type = list(string)
    description= "vm names"
    default=["web_disp1","web_disp2"]
}
