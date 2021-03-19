# Runing a Presearch Node on DigitalOcean

[Presearch](https://presearch.org) is a decentralized search engine that uses blockchain technologies. It provides privacy while also allowing you to earn Presearch's coin, Pre.

Running a node helps to support the network by responding to search requests.

## Getting Started

The essence of the setup is in the `presearch_node_bootstrap.sh`. The script handles the following:

1. Adds the Docker Apt repo.
1. Installs Docker
1. Starts the `containrrr/watchtower` container to update the presearch node container when it is updated
1. Starts the `presearch/node` container

Both containers are started in daemon mode and set to restart.

You can create a droplet via the DigitalOcean control panel and add this script to get set up. You just need to copy the file to your server, make it executable and run it.

```
# To copy the script replace $SERVER_IP with your servers IP address.
$ scp presearch_node_bootstrap.sh root@$SERVER_IP
```

Once the script is on the server, you can run it.

```
# ssh to your server and run these commands
$ chmod +x presearch_node_bootstrap.sh
$ ./presearch_node_bootstrap.sh
```

When the script is done, you'll have Presarch Node running. You can look at the logs by ssh'ing to your server and running:

```
$ docker -f logs presearch-node
```

### Using Terraform

You can use [Terraform](https://www.terraform.io/) to automate spinning up the cloud server and running the `presearch_node_bootstrap.sh`. Once you install Terraform you can get started by running:

```
$ terraform init
```

That ensures you have the DigitalOcean provider so you can create a VM (Droplet).

```
$ terraform apply
```

This will prompt you for two values.

1. do_token - This is your API token you can create in the DigitalOcean Admin Panel
2. private_key - The path to your ssh key that would be used to log into your Droplet.
3. ssh_key_name - The name of the ssh key when you added it to your DigitalOcean account.

Currently this assumes you have a ssh key called `main` you've added to your account. You can edit `provider.tf` and change the respective `digitalocean_ssh_key` settings.

When it is finished you should have a Droplet up with Presearch Node running. You can ssh into the Droplet and verify things are running as expected.
