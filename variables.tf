variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.0"
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.8"
}

variable "node_shape" {
  type        = string
  description = "Instance shape for node instance to use."
  default     = "VM.Standard2.1"
}

variable "label_prefix" {
  default = ""
}

variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "node_count" {
  default = 6
}

variable "seeds_count" {
  default = 3
}

variable "storage_port" {
  default = 7000
}

variable "ssl_storage_port" {
  default = 7001
}

variable "cassandra_version" {
  description = "Version of Cassandra software"
  default     = "3.11.10"
}
