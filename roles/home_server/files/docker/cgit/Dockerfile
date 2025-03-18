# This file was written by Damien Dart, <damiendart@pobox.com>. This is
# free and unencumbered software released into the public domain. For
# more information, please refer to the accompanying "UNLICENCE" file.

FROM alpine
RUN apk add cgit git lighttpd

COPY lighttpd-cgit.conf /etc/lighttpd/cgit.conf
COPY cgitrc /etc/cgitrc

RUN echo 'include "cgit.conf"' >> /etc/lighttpd/lighttpd.conf

EXPOSE 9091
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
