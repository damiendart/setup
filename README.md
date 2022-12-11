setup
=====

Stuff that I use to provision and maintain a bunch of machines and
things for personal use, including development environments and a couple
of servers where I host a few small websites.

This project mainly consists of [Ansible][] playbooks and roles, but
there’s also some [Docker Compose][], [TestInfra][], and [Packer][]
bits-and-pieces hanging around.

  [Ansible]: <https://docs.ansible.com/ansible/latest/index.html>
  [Docker Compose]: <https://docs.docker.com/compose/>
  [TestInfra]: <https://testinfra.readthedocs.io/en/latest/>
  [Packer]: <https://www.packer.io/>


## Setting up *setup*

The following is a rough guide on how I go about setting up Ansible and
*setup* on a fresh install of Ubuntu 18.04 or 20.04:

1.  Install Git and pip with APT
    (`sudo apt install -y --no-install-recommends git python3-pip`).
2.  Install virtualenv and virtualenvwrapper with pip
    (`python3 -m pip install --no-warn-script-location --user --upgrade virtualenv virtualenvwrapper`)
3.  [Generate an SSH key][] and add the public key to things (Ansible
    inventories, GitHub, servers, etc) where appropriate.
4.  Use Git to download copies of *setup*, relevant Ansible inventories,
    and [my dotfiles][]. (Be aware that the *development* Ansible role
    will also download a copy of my dotfiles, for more information see
    *roles/development/tasks/dotfiles.yml*.)
5.  Run the install script included with my dotfiles. Log out and log
    back in, or `source` any new dotfiles so that they take effect in
    the current interactive shell session.
6.  Create a new Python virtual environment (`mkvirtualenv setup`). Once
    the new environment has been created it should be activated
    automatically (if not, use the `workon` command to activate it).
7.  `cd` into the *setup* directory and install Ansible and other Python
    dependencies with `python3 -m pip install -r requirements.txt`.

See also [my notes on setting up a personal development environment][].

  [Generate an SSH key]: <https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key>
  [my dotfiles]: <https://www.robotinaponcho.net/git/#toolbox>
  [my notes on setting up a personal development environment]: <https://www.robotinaponcho.net/notes/ubuntu-desktop-setup>


## Testing server state

There is also a small test suite that uses TestInfra to perform some
server state tests. These tests are currently a bit bare-bones and are a
work-in-progress.

Note that you’ll need to set the *ControlMaster* and *ControlPath*
configuration options when testing over SSH, otherwise Fail2Ban and UFW
will quickly put a stop to your testing.


## Linting and style guide

For Ansible-related files, there’s a bunch of editor configuration and
linting gubbins that should keep most things relatively consistent. For
more information, see *.ansible-lint*, *.editorconfig*, *Taskfile.yml*,
and *.yamllint*.

For things that the above doesn’t cover, the aim is to adhere to the
[Ansible Best Practices guide][] and the [WhiteCloud Ansible style
guide][] with the following additions:

-   Files should start, where appropriate, with:
    -   a comment that includes a sentence explaining the file’s
        purpose, any additional information, and the file’s licence; and
    -   a blank line, followed by `---`.
-   Variable names should be prefixed with:
    -   `{{ ROLE_NAME }}__` if the variable is defined in an role,
    -   `cli__` if the variable is defined in a playbook and should be
        set through the command-line interface, or
    -   `__` if the variable is a registered during a play and is not
        meant to be defined anywhere else.

Using poor-man’s variable namespacing makes it easier to search for role
variables (as an example, running
`rg -Io "webserver__[a-zA-Z_]*" roles/webserver | sort | uniq` will list
all variables in the “webserver” role that can be overriden).

  [Ansible Best Practices guide]: <https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html>
  [WhiteCloud Ansible style guide]: <https://github.com/whitecloud/ansible-styleguide>
