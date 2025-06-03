apt\_maintainance
=================

Performs maintainance tasks on packages installed and managed by APT,
including the removal of any out-of-date and unused packages.

Before any changes are made, a list of affected packages is displayed
and the user is given the option of continuing or exiting. Therefore
this role isn't suitable for playbooks intended to be run unattended.


## Configuration and usage

There are no role variables.

For example usage, see the "playbook-package-maintainance.yml" playbook
at the project root.


## Notes

If the "Ensure APT package lists are up-to-date" task fails with "Failed
to update apt cache: unknown reason", run `sudo apt update` and check
for any warnings or errors.

If Ansible hangs while running any of the tasks that use the
`ansible.builtin.apt` module, it may be that an interactive prompt of
some kind has appeared which cannot be actioned through Ansible.

There are no doubt more elegant ways of dealing with this, but I've
managed by first interrupting the playbook with
<kbd>Ctrl</kbd>+<kbd>C</kbd>, then on the host giving you grief:

  - Kill the in-limbo APT-related process (you can find the PID of the
    process with `ps aux | grep -i apt`).
  - Run `sudo dpkg --configure -a` (this might not be neccesary; from
    what I remember when I tried to run any sort of APT command
    beforehand it bombed out and told me to run this command first).
  - Rerun the command that Ansible was trying to run and action any
    prompts that appear.
