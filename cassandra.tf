# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE CASSANDRA CLUSTER
# ---------------------------------------------------------------------------------------------------------------------
module "cassandra" {
  source              = "github.com/oracle-quickstart/oci-cassandra"
  compartment_ocid     = var.compartment_ocid
  node_count           = var.node_count
  seeds_count          = var.seeds_count
  availability_domains = data.template_file.ad_names.*.rendered
  subnet_ocids         = oci_core_subnet.CassandraSubnet.*.id
  vcn_cidr             = oci_core_virtual_network.CassandraVCN.cidr_block
  image_ocid           = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  node_shape           = var.node_shape
  storage_port         = var.storage_port
  ssl_storage_port     = var.ssl_storage_port
  ssh_authorized_keys  = tls_private_key.public_private_key_pair.public_key_openssh
  ssh_private_key      = tls_private_key.public_private_key_pair.private_key_pem
}
