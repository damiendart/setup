setup
=====

A mess of [Ansible][1] stuff that I use to provision and maintain a
bunch of Ubuntu 18.04 installations, including personal development
environments and a couple of servers where I host a few small websites.

[1]: <https://docs.ansible.com/ansible/latest/index.html>


## Testing server state

There is also a small test suite that uses [TestInfra][2] to perform
some server state tests. These tests are currently a bit bare-bones and
are a work-in-progress.

Note that you'll need to set the _ControlMaster_ and _ControlPath_
configuration options when testing over SSH, otherwise Fail2Ban and UFW
will quickly put a stop to your testing.

[2]: <https://testinfra.readthedocs.io/en/latest/>


## Linting and style guide

There's a bunch of editor-configuration and linting gubbins that should
keep most things relatively consistent. For more information, see
_.ansible-lint_, _.editorconfig_, _Taskfile.yml_, and _.yamllint_.

For things that the above doesn't cover, the aim is to adhere to the
[Ansible Best Practices guide][3] and the [WhiteCloud Ansible
style guide][4] with the following amendments:

  - Files should start, where appropriate, with
    - a comment that includes a sentence explaining the file's purpose,
      any additional information, and the file's licence; and
    - a blank line, followed by `---`.
  - Variable names should be prefixed with:
    - `{{ ROLENAME }}__` if the variable is defined and used in an role,
    - `cli__` if the variable is meant to be set through the
      command-line interface, or
    - `__` if the variable is not meant to be overridden elsewhere.

[3]: <https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html>
[4]: <https://github.com/whitecloud/ansible-styleguide>
