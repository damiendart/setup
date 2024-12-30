Getting Started
===============

## Setting up Ansible and *setup*

The following is a rough guide on setting up the bare minimum required
to get Ansible and *setup* working on a fresh install of Ubuntu 20.04:

1.  Install Git: `sudo apt install -y --no-install-recommends git`) and
    use it to download *setup* and any relevant Ansible inventories.
2.  [Generate an SSH key][] and add the public key to Ansible
    inventories, GitHub, applicable servers, etc.
3.  Download [a standalone build of Python 3.13][] and [extract it][] to
    `/usr/local/python`. (Refer to the included *python* Ansible role
    for guidance on which distribution to download.)
4.  `cd` into the *setup* directory.
5.  Create and activate a new Python virtual environment:
    `/usr/local/python/bin/python3.13 -m venv .venv && source .venv/bin/activate`.
6.  Install Ansible (and other Python dependencies) with
    `.venv/bin/python3.13 -m pip install -r requirements.txt`.

The above guide perform actions similar to those in the included Ansible
roles to prevent configuration and machine state drift once you start
managing the machine with Ansible.

(These steps could be automated, but the number of times I’ve found
myself in a situation that I needed to install Ansible and *setup* from
scratch are incredible rare.)

  [Generate an SSH key]: <https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key>
  [a standalone build of Python 3.13]: <https://github.com/astral-sh/python-build-standalone>
  [extract it]: <https://gregoryszorc.com/docs/python-build-standalone/main/running.html#extracting-distributions>


## Example commands for running playbooks and stuff

``` shell
$ export ANSIBLE_VAULT_PASSWORD_FILE=/path/to/.vault-password
$ ansible-playbook -i ../secret/ansible --limit development playbook-provision.yml
```
