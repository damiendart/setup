Getting Started
===============

## Setting up Ansible and *setup*

The following is a rough guide on setting up the bare minimum required
to get Ansible and *setup* working a fresh install of Ubuntu 20.04:

1.  Install the required packages with APT:
    `sudo apt install -y --no-install-recommends git python3-pip python3-venv`).
2.  [Generate an SSH key][] and add the public key to things where
    appropriate (Ansible inventories, GitHub, servers, etc).
3.  Use Git to download copies of *setup* and any relevant Ansible
    inventories.
4.  `cd` into the *setup* directory.
5.  Create and activate a new Python virtual environment:
    `python3.8 -m venv .venv && source .venv/bin/activate`.
6.  Install Ansible (and other Python dependencies) with
    `.venv/bin/python -m pip install -r requirements.txt`.

  [Generate an SSH key]: <https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key>


## Example commands for running playbooks and stuff

``` shell
$ export ANSIBLE_VAULT_PASSWORD_FILE=/path/to/.vault-password
$ ansible-playbook -i ../secret/ansible --limit development playbook-provision.yml
```
