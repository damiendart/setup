# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE" file.

packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

variable "ssh_public_key_file" {
  type = string
  default = "${env("HOME")}/.ssh/id_ed25519.pub"
}

source "virtualbox-iso" "debian-virtualbox" {
  boot_command = [
    "<wait><wait><wait><esc><wait><wait><wait>",
    "/install.amd/vmlinuz ",
    "initrd=/install.amd/initrd.gz ",
    "auto=true ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed ",
    "hostname=virtualbox ",
    "domain=virtualbox.test ",
    "interface=auto ",
    "vga=788 noprompt quiet --<enter>"
  ]
  boot_wait = "5s"
  headless = false
  http_content = {
    "/preseed" = join(
      "\n",
      [
        "d-i debian-installer/locale string en_GB",
        "d-i keyboard-configuration/xkb-keymap select gb",
        "d-i netcfg/choose_interface select auto",
        "d-i netcfg/get_hostname string unassigned-hostname",
        "d-i netcfg/get_domain string unassigned-domain",

        "d-i passwd/user-fullname string Debian",
        "d-i passwd/username string debian",
        "d-i passwd/user-password password debian",
        "d-i passwd/user-password-again password debian",
        "d-i user-setup/allow-password-weak boolean true",
        "d-i user-setup/encrypt-home boolean false",
        "d-i passwd/root-login boolean false",

        "d-i hw-detect/load_firmware boolean false",
        "d-i hw-detect/load_media boolean false",
        "apt-cdrom-setup apt-setup/cdrom/set-first boolean false",
        "d-i mirror/country string manual",
        "d-i mirror/http/hostname string deb.debian.org",
        "d-i mirror/http/directory string /debian",
        "d-i mirror/http/proxy string",
        "d-i apt-setup/contrib boolean true",
        "d-i apt-setup/non-free boolean true",
        "d-i apt-setup/disable-cdrom-entries boolean true",
        "tasksel tasksel/first multiselect ssh-server, standard",
        "d-i pkgsel/upgrade select full-upgrade",
        "d-i pkgsel/include string sudo, unattended-upgrades",
        "popularity-contest popularity-contest/participate boolean false",

        "d-i grub-installer/only_debian boolean true",
        "d-i grub-installer/with_other_os boolean true",
        "d-i grub-installer/bootdev string default",
        "d-i partman-auto/disk string /dev/sda",
        "d-i partman-lvm/device_remove_lvm boolean true",
        "d-i partman-md/device_remove_md boolean true",
        "d-i partman-partitioning/confirm_write_new_label boolean true",
        "d-i partman/choose_partition select finish",
        "d-i partman/confirm boolean true",
        "d-i partman/confirm_nooverwrite boolean true",
        "d-i partman-auto/method string lvm",
        "d-i partman-auto-lvm/new_vg_name string primary",
        "d-i partman-auto-lvm/guided_size string max",
        "d-i partman-lvm/confirm boolean true",
        "d-i partman-lvm/confirm_nooverwrite boolean true",
        "d-i partman-auto/choose_recipe select atomic",

        "d-i finish-install/reboot_in_progress note"
      ]
    )
  }
  iso_checksum = "0b813535dd76f2ea96eff908c65e8521512c92a0631fd41c95756ffd7d4896dc"
  iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.4.0-amd64-netinst.iso"
  guest_os_type = "Debian_64"
  memory = 2048
  shutdown_command = "echo 'debian' | sudo -S shutdown -P now"
  ssh_password = "debian"
  ssh_timeout = "20m"
  ssh_username = "debian"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"],
  ]
  vboxmanage_post = [
    ["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "off"],
  ]
}

build {
  sources = ["sources.virtualbox-iso.debian-virtualbox"]

  provisioner "file" {
    destination = "/tmp/authorized_keys"
    source = var.ssh_public_key_file
  }

  provisioner "file" {
    destination = "/tmp/virtualbox_network"
    content = join(
      "\n",
      [
        "allow-hotplug enp0s8",
        "iface enp0s8 inet dhcp",
        "iface enp0s8 inet6 dhcp",
      ]
    )
  }

  provisioner "shell" {
    inline = [
      "echo 'debian' | sudo -S -E mv /tmp/virtualbox_network /etc/network/interfaces.d/",
      "echo 'debian' | sudo -S -E chmod 644 /etc/network/interfaces.d/virtualbox_network",

      "echo 'debian' | sudo -S -E mkdir /home/debian/.ssh",
      "echo 'debian' | sudo -S -E chmod 700 /home/debian/.ssh/",
      "echo 'debian' | sudo -S -E mv /tmp/authorized_keys /home/debian/.ssh/",
      "echo 'debian' | sudo -S -E chmod 600 /home/debian/.ssh/authorized_keys",
      "echo 'debian' | sudo -S -E chown -R debian:debian /home/debian/.ssh/"
    ]
  }
}
