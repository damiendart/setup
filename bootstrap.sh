#!/bin/sh
#
# Installs a non-system version of Python, which can then be managed
# with Ansible afterwards.
#
# When editing this file, ensure that the Python version installed by
# this Shell script matches the version installed by the "python"
# Ansible role (see "roles/python/defaults/main.yml").
#
# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE" file.

set -e

if [ "$(id -u)" -ne 0 ]; then
  echo 'Please run this script as root or using sudo.'
  exit 1
fi

if [ -d /usr/local/python ]; then
  echo 'It looks like an Ansible-managed version of Python already exists.'
  printf 'Are you sure you want to continue (y/n): '
  read -r REPLY
  case $REPLY in
    [yY]*)
      ;;
    *)
      echo "Aborting."
      exit 1
      ;;
  esac
fi

PYTHON_ARCHIVE_CHECKSUM='cb1aab17b3ed7c1d9cccac8d7988589d4848a0c23c8d94f282639f97e4868c33'
PYTHON_ARCHIVE_URL='https://github.com/astral-sh/python-build-standalone/releases/download/20260325/cpython-3.13.12+20260325-x86_64_v3-unknown-linux-gnu-install_only.tar.gz'
PYTHON_VERSION='3.13.12'

TEMP="$(mktemp --suffix='.tar.gz')"

echo "Downloading and verifying Python $PYTHON_VERSION binary archive..."
curl --location --silent --output "$TEMP" "$PYTHON_ARCHIVE_URL"
echo "$PYTHON_ARCHIVE_CHECKSUM $TEMP" | sha256sum -c --quiet -

echo "Installing Python $PYTHON_VERSION to \"/usr/local/python\"..."
rm -fr /usr/local/python
mkdir -p /usr/local/python
tar -C /usr/local/python -f "$TEMP" -xz --strip-components=1

echo "Cleaning up..."
rm -fr "$TEMP"

echo "All done!"
