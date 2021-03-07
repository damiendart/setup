setup
=====

A mess of [Ansible][1] stuff that I use to provision and maintain a
bunch of Ubuntu 18.04 and 20.04 installations, including personal
development environments and a couple of servers where I host a few
small websites.

[1]: <https://docs.ansible.com/ansible/latest/index.html>


## Setting up _setup_

The following is a rough guide on how I go about setting up Ansible and
_setup_ on a fresh install of Ubuntu 18.04 or 20.04:

  1) Install Git and pip with APT (`sudo apt install -y
     --no-install-recommends git python3-pip`).
  2) Install virtualenv and virtualenvwrapper with pip (`python3 -m pip
     install --no-warn-script-location --user --upgrade virtualenv
     virtualenvwrapper`)
  3) [Generate an SSH key][2] and add the public key to things (Ansible
     inventories, GitHub, servers, etc) where appropriate.
  4) Use Git to download copies of _setup_, relevant Ansible
     inventories, and [my dotfiles][3].
  5) Run the install script included with my dotfiles. Log out and log
     back in, or `source` any new dotfiles so that they take effect in
     the current interactive shell session.
  6) Create a new Python virtual environment (`mkvirtualenv setup`).
  7) `cd` into the _setup_ directory and install Ansible and other
     Python dependencies with `python3 -m pip install -r
     requirements.txt`.

[2]: <https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key>
[3]: <https://www.robotinaponcho.net/git/#toolbox>


## Testing server state

There is also a small test suite that uses [TestInfra][4] to perform
some server state tests. These tests are currently a bit bare-bones and
are a work-in-progress.

Note that you'll need to set the _ControlMaster_ and _ControlPath_
configuration options when testing over SSH, otherwise Fail2Ban and UFW
will quickly put a stop to your testing.

[4]: <https://testinfra.readthedocs.io/en/latest/>


## Linting and style guide

There's a bunch of editor-configuration and linting gubbins that should
keep most things relatively consistent. For more information, see
_.ansible-lint_, _.editorconfig_, _Taskfile.yml_, and _.yamllint_.

For things that the above doesn't cover, the aim is to adhere to the
[Ansible Best Practices guide][5] and the [WhiteCloud Ansible
style guide][6] with the following amendments:

  - Files should start, where appropriate, with
    - a comment that includes a sentence explaining the file's purpose,
      any additional information, and the file's licence; and
    - a blank line, followed by `---`.
  - Variable names should be prefixed with:
    - `{{ ROLENAME }}__` if the variable is defined and used in an role,
    - `cli__` if the variable is meant to be set through the
      command-line interface, or
    - `__` if the variable is not meant to be overridden elsewhere.

[5]: <https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html>
[6]: <https://github.com/whitecloud/ansible-styleguide>
