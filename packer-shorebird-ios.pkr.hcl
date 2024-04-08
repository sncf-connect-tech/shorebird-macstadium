variable "endpoint" {
  type = string
}

variable "orka_user" {
  type = string
}

variable "orka_password" {
  type      = string
  sensitive = true
}

variable "vm_ssh_username" {
  type = string
}

variable "vm_ssh_password" {
  type      = string
  sensitive = true
}

variable "base_image" {
  type = string
}

variable "image_name" {
  type = string
}

variable "vm_cpu_number" {
  type = number
}

variable "flutter_version" {
  type = string
}

variable "cocoapod_version" {
  type = string
}

variable "vm_builder_prefix" {
  type    = string
  default = "ci-shorebird-image-vm-builder"
}

source "macstadium-orka" "image" {
  source_image           = "${var.base_image}"
  image_name             = "${var.image_name}"
  orka_endpoint          = "${var.endpoint}"
  orka_user              = "${var.orka_user}"
  orka_password          = "${var.orka_password}"
  ssh_username           = "${var.vm_ssh_username}"
  ssh_password           = "${var.vm_ssh_password}"
  orka_vm_cpu_core       = "${var.vm_cpu_number}"
  orka_vm_builder_prefix = "${var.vm_builder_prefix}"
}

build {

  sources = [
    "macstadium-orka.image"
  ]


  provisioner "shell" {
    environment_vars = [
      "FLUTTER_VERSION=${var.flutter_version}",
      "COCOAPODS_VERSION=${var.cocoapod_version}",
      "VM_SSH_PASSWORD=${var.vm_ssh_password}",
    ]
    script = "bin/install-macstadium-shorebird"
  }
}
