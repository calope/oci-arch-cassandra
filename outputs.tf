output "node_public_ips" {
  value = module.cassandra.node_public_ips
}

output "node_private_ips" {
  value = module.cassandra.node_private_ips
}

output "generated_ssh_private_key" {
  value = tls_private_key.public_private_key_pair.private_key_pem
}