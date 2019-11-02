#!/usr/bin/python3

from collections import Counter
import re
import subprocess
import sys


def main():
    domains = sys.argv[1:]
    output = subprocess.run(
        ['/usr/bin/certbot', 'certificates'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )

    output.check_returncode()

    groups = re.search(
        r'Certificate Name: %s\n.*Domains: (?P<domains>.*)$' % sys.argv[1],
        output.stdout.decode('utf8'),
        re.MULTILINE
    )

    if groups is None:
        output = subprocess.run(
            [
                '/usr/bin/certbot',
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
                '/usr/bin/certbot',
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
