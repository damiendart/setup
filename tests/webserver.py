#!/usr/bin/python3
# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE" file.

def test_apache_is_installed_and_a_recent_version(host):
    apache = host.package("apache2")

    assert apache.is_installed
    # The custom configuration files that the accompanying Ansible role
    # install use directives available in Apache versions 2.4 and later.
    assert apache.version.startswith("2.4")


def test_apache_running_and_enabled(host):
    apache = host.service("apache2")

    assert apache.is_running
    assert apache.is_enabled


def test_apache_workers_are_running(host):
    master = host.process.get(user="root", comm="apache2")

    assert len(host.process.filter(ppid=master.pid)) > 0


def test_are_we_listening_for_http_traffic(host):
    assert host.socket("tcp://0.0.0.0:80").is_listening
    assert host.socket("tcp://:::80").is_listening


def test_are_we_listening_for_https_traffic(host):
    assert host.socket("tcp://0.0.0.0:443").is_listening
    assert host.socket("tcp://:::443").is_listening
