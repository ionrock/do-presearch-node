resource "digitalocean_droplet" "presearch-node" {
  image = "ubuntu-20-04-x64"
  name = "presearch-node"
  region = "sfo3"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.main.id
  ]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.private_key)
    timeout = "2m"
  }

  provisioner "file" {
    source = "presearch_node_bootstrap.sh"
    destination = "/opt/presearch_node_bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /opt/presearch_node_bootstrap.sh",
      "/opt/presearch_node_bootstrap.sh",
    ]
  }
}
