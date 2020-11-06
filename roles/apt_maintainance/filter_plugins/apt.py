#!/usr/bin/python3
# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE" file.


class FilterModule(object):
    def filters(self):
        return {
            'apt_simulate_output_cleanup': self.apt_simulate_output_cleanup
        }

    def apt_simulate_output_cleanup(self, lines):
        output = []

        for line in lines:
            if line.startswith('Inst'):
                words = line.split(' ')

                new_line = '{0}: {1} => {2}'.format(
                    words[1],
                    words[2][1:-1],
                    words[3][1:]
                )
                output.append(new_line)

            elif line.startswith('Remv'):
                words = line.split(' ')
                output.append(words[1])

        return sorted(output)
