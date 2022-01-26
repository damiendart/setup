# A Packer template to build a test Ubuntu 20.04 VirtualBox VM.
#
# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE" file.

variable "netplan_configuration" {
  description = "A HCL-formatted netplan network configuration to apply to the virtual machine."
  # The default netplan network configuration provided assumes that the
  # virtual machine has two network adapters enabled: the default
  # NAT-attached adapter and an adapter that is attached to a
  # VirtualBox-managed host-only network with the DHCP server enabled
  # (see <https://www.virtualbox.org/manual/ch06.html#network_hostonly>
  # for more information).
  default = {
    ethernets = {
      enp0s3 = {
        dhcp4 = true
      }
      enp0s8 = {
        dhcp4 = true
      }
    }
    version = 2
  }
}

variable "ssh_authorised_keys_file" {
  type = string
  description = "The filepath to an authorised SSH keys file to copy over to the virtual machine."
  default = "${env("HOME")}/.ssh/authorized_keys"
}

source "virtualbox-iso" "ubuntu-server-virtualbox" {
  boot_command = [
    "<esc><esc><esc>",
    "<enter><wait>",
    "/casper/vmlinuz root=/dev/sr0 initrd=/casper/initrd ",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter>"
  ]
  boot_wait = "5s"
  headless = false
  http_content = {
    "/meta-data" = ""
    "/user-data" = join(
      "\n",
      [
        "#cloud-config",
        yamlencode({
          autoinstall = {
            early-commands = [
              # The OpenSSH server is stopped during installation to
              # prevent Packer trying to connect to it and bombing out.
              "systemctl stop ssh"
            ]
            identity = {
              hostname = "playground-ubuntu"
              # Generated with "openssl passwd -6 -salt xyz ubuntu".
              password = "$6$xyz$lrzkz89JCrvzOPr56aXfFFqGZpBReOx5ndDu9m5CwVFWjZsEIhvVm.I5B4zMxJdcdTyAvncwjKT.dWcD/ZHIo."
              username = "ubuntu"
            }
            keyboard = {
              layout = "en"
              variant = "uk"
            }
            locale = "en_GB.UTF-8"
            network = var.netplan_configuration
            ssh = {
              allow-pw = true
              authorized-keys: split("\n", file(var.ssh_authorised_keys_file))
              install-server = true
            }
            version: 1
          }
        })
      ]
    )
  }
  iso_checksum = "f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
  iso_url = "https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso"
  guest_os_type = "Ubuntu_64"
  memory = 2048
  shutdown_command = "echo 'ubuntu' | sudo -S shutdown -P now"
  ssh_password = "ubuntu"
  ssh_timeout = "20m"
  ssh_username = "ubuntu"
}

build {
  sources = ["sources.virtualbox-iso.ubuntu-server-virtualbox"]
}
