#!/usr/bin/python3
# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE" file.


from collections import Counter
import re
import subprocess
import sys


def main():
    domains = sys.argv[1:]
    output = subprocess.run(
        ['/snap/bin/certbot', 'certificates'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )

    output.check_returncode()

    groups = re.search(
        r'Certificate Name: %s\n.*\n.*\n.*Domains: (?P<domains>.*)$' % sys.argv[1],  # noqa: E501
        output.stdout.decode('utf8'),
        re.MULTILINE
    )

    if groups is None:
        output = subprocess.run(
            [
                '/snap/bin/certbot',
                'certonly',
                '--webroot',
                '-w',
                '/var/www/html/',
                '-d',
                ', '.join(domains)
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        output.check_returncode()

        print('Certificate created!')
    elif Counter(re.split(r',? ', groups['domains'])) != Counter(domains):
        output = subprocess.run(
            [
                '/snap/bin/certbot',
                'certonly',
                '--cert-name',
                domains[0],
                '--webroot',
                '-w',
                '/var/www/html/',
                '-d',
                ', '.join(domains)
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        output.check_returncode()

        print('Certificate updated!')
    else:
        print('No action required!')


if __name__ == '__main__':
    main()
