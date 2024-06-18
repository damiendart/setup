#!/usr/bin/python3
# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE" file.

import re


def test_imagemagick_has_pdf_and_webp_support(host):
    cmd = host.run("convert identify -list format")

    assert cmd.succeeded
    assert re.search(r"PDF\s*rw+", cmd.stdout)
    assert re.search(r"WEBP\s*rw[-+]", cmd.stdout)
