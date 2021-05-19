## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

############################################
# Create VCN
############################################
resource "oci_core_virtual_network" "CassandraVCN" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = "CassandraVCN"
  dns_label      = "ocicassandra"
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

############################################
# Create Internet Gateways
############################################
resource "oci_core_internet_gateway" "CassandraIG" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.label_prefix}CassandraIG"
  vcn_id         = oci_core_virtual_network.CassandraVCN.id
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

############################################
# Create Route Table
############################################
resource "oci_core_route_table" "CassandraRT" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.CassandraVCN.id
  display_name   = "${var.label_prefix}CassandraRouteTable"

  route_rules {
    cidr_block = "0.0.0.0/0"

    # Internet Gateway route target for instances on public subnets
    network_entity_id = oci_core_internet_gateway.CassandraIG.id
  }
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

############################################
# Create Security List
############################################
resource "oci_core_security_list" "CassandraSL" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.label_prefix}CassandraSecurityList"
  vcn_id         = oci_core_virtual_network.CassandraVCN.id

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }

  ingress_security_rules {  
      tcp_options {
        max = var.storage_port
        min = var.storage_port
      }
      protocol = "6"
      source   = "0.0.0.0/0"
  }

  ingress_security_rules { 
      tcp_options {
        max = var.ssl_storage_port
        min = var.ssl_storage_port
      }
      protocol = "6"
      source   = "0.0.0.0/0"
  }    
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

############################################
# Create Subnets
############################################
resource "oci_core_subnet" "CassandraSubnet" {
#  count               = length(data.template_file.ad_names.*.rendered)
#  availability_domain = data.template_file.ad_names.*.rendered[count.index]
#  cidr_block          = cidrsubnet(var.vcn_cidr, ceil(log(length(data.template_file.ad_names.*.rendered) * 2, 2)), length(data.template_file.ad_names.*.rendered) + count.index)
#  display_name        = "${var.label_prefix}CassandraSubnet${count.index+1}"
#  dns_label           = "cassandra${count.index+1}"
  cidr_block          = var.subnet_cidr
  display_name        = "${var.label_prefix}CassandraSubnet"
  dns_label           = "cassandra"
  security_list_ids   = [oci_core_virtual_network.CassandraVCN.default_security_list_id, oci_core_security_list.CassandraSL.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_virtual_network.CassandraVCN.id
  route_table_id      = oci_core_route_table.CassandraRT.id
  dhcp_options_id     = oci_core_virtual_network.CassandraVCN.default_dhcp_options_id
  defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
