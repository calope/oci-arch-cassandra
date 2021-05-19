## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1"
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.9"
}

variable "node_shape" {
  type        = string
  description = "Instance shape for node instance to use."
  default     = "VM.Standard.E3.Flex"
}

variable "node_flex_shape_ocpus" {
   default = 1
}

variable "node_flex_shape_memory" {
   default = 10
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
