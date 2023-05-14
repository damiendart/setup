Testing machine state
=====================

There is a small test suite that uses TestInfra to test machine state.

These tests are currently a bit bare-bones and are a work-in-progress.

For local environment testing, I use the following command:

``` shell
$ py.test -v --ansible-inventory="[PATH-TO-INVENTORY]" --hosts="ansible://development" tests/*
```

For servers that have Fail2Ban and UFW, I’ve found that the
*ControlMaster*, *ControlPath*, and *ControlPersist* SSH configuration
options need to be configured:

``` shell
$ ANSIBLE_SSH_COMMON_ARGS="-o ControlMaster=auto -o ControlPath=/tmp/test.sock -o ControlPersist=60s" py.test -v --ansible-inventory="[PATH-TO-INVENTORY]" --hosts="ansible://production" tests/*
```
