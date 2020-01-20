setup
=====

A mess of Ansible stuff that I use to provision and maintain my personal
development environment and a couple of servers that I host a few small
websites on.

  - I currently use Ubuntu 18.04, so the included Ansible playbooks and
    roles have only been tested there.
  - All Ansible hosts must have Python 3 installed beforehand.
  - Mitogen has been included as a dependency, but you'll need to
    [manually set it up][1] for it to take effect.

[1]: <https://mitogen.networkgenomics.com/ansible_detailed.html#installation>


## Linting and style guide

There's a bunch of editor-configuration and linting gubbins that should
keep most things relatively consistent. For more information, see
_.ansible-lint_, _.editorconfig_, _Taskfile.yml_, and _.yamllint_.

For things that the above doesn't cover, the aim is to adhere to the
[Ansible Best Practices guide][2] and the [WhiteCloud Ansible
style guide][3] with the following amendments:

  - Files should start, where appropriate, with 
    - a comment that includes a sentence explaining the file's purpose,
      any additional information, and the file's licence; and
    - a blank line, followed by `---`.
  - Variable names should be prefixed with:
    - `{{ ROLENAME }}__` if the variable is defined and used in an role,
    - `cli__` if the variable is meant to be set through the
      command-line interface, or
    - `__` if the variable is not meant to be overridden elsewhere.

[2]: <https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html>
[3]: <https://github.com/whitecloud/ansible-styleguide>
