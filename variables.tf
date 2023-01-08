variable "image_id" {
  type = string
  description = "The id of the machine image (AMI) to use for server."
  default = "fd8jvcoeij6u9se84dt5"
}

variable "vm_name" {
  type = string
  description = "Virtual machine name"
  default = "vm"
}

variable "labels" {
  type = map(string)
  description = "Labels for created objects"
}

variable "resources" {
  type = object({
    cpu = number
    memory = number
    disk = number
  })
  description = "Compute instance resources"
}

variable "cidr_blocks" {
  type = list(string)
  description = "CIDR blocks"
}

variable "lb_listener_port" {
  type = number
  description = "Port for incoming traffic"
}

variable "nlb_healthcheck" {
  type = object({
    name = string
    port = number
    path = string
  })
  description = "Network load balancer healthchecks"
}

variable "public_ssh_key_path" {
  type = string
  default = ""
  description = "Path to ssh public key"
}

variable "az" {
  type = list(string)
  default = [ "ru-central1-a", "ru-central1-b", "ru-central1-c" ]
}

variable "vm_count" {
  type = number
  default = 0
  description = "Number of VMs to create"
}

variable "vm_image_family" {
  type = string
  description = "Image name"
}

variable "allocate_public_ip" {
  type = bool
  description = "Allocate public IP for VM"
  default = false
}