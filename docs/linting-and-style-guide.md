Linting and style guide
=======================

## Ansible-related files

There’s a bunch of editor configuration and linting gubbins that should
keep most things relatively consistent. For more information, see
*.ansible-lint*, *.editorconfig*, *Taskfile.yml*, and *.yamllint* in the
project root.

For things that automated processes doesn’t cover, the aim is to adhere
to the [Ansible Best Practices guide][] and the [WhiteCloud Ansible
style guide][] with the following additions/changes:

- Files should start, where appropriate, with:
  - a file comment with a sentence explaining the file’s purpose, any
    additional information, and the file’s licence; and
  - a blank line, followed by `---`.
- Variable names should be prefixed with:
  - `{{ ROLE_NAME }}__` for role variables defined in the *defaults* and
    *vars* folders,
  - `cli__` if the variable is defined in a playbook and should be set
    through the command-line interface, or
  - `__` if the variable is a “local” variable: one that is registered
    during a play and is not meant to be defined anywhere else.

Using poor-man’s variable namespacing makes it easier to search for
variables. For example, running the following shell command will list
all variables in the “webserver” role that can be overridden:

``` shell
$ rg -Io "golang__[a-zA-Z_]*" -g '!roles/golang/defaults' roles/golang | sort | uniq
```

  [Ansible Best Practices guide]: <https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html>
  [WhiteCloud Ansible style guide]: <https://github.com/whitecloud/ansible-styleguide>
