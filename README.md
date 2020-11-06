setup
=====

A mess of Ansible stuff that I use to provision and maintain my personal
development environments and a couple of servers that I host a few small
websites on.

  - I use macOS Catalina and Ubuntu 18.04 so your mileage may vary when
    it comes to using the included Ansible playbooks and roles on any
    other operating systems.
  - All Ansible hosts must have Python 3 installed beforehand.

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
