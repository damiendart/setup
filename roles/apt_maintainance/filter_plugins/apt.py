#!/usr/bin/python3
# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE" file.


class FilterModule(object):
    def filters(self):
        return {
            "apt_simulate_output_cleanup": self.apt_simulate_output_cleanup,
        }

    def apt_simulate_output_cleanup(self, lines):
        output = []

        for line in lines:
            words = line.split(" ")

            if line.startswith("Inst"):
                output.append(
                    "{0}: {1} => {2}".format(
                        words[1],
                        words[2][1:-1],
                        words[3][1:],
                    ),
                )
            elif line.startswith("Remv"):
                output.append("{0}: REMOVED".format(words[1]))

        return sorted(output)
