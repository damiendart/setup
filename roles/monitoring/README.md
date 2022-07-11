monitoring
==========

Sets up a bunch of monitoring-related stuff, including:

-   Installing and configuring [Fail2Ban][], [logrotate][],
    [Logwatch][], [Monit][], and [Prometheus Node Exporter][]; and
-   installing various custom notification scripts.

Generally, any notifications will be set up to be sent via email. With
the custom notification scripts that require a little more urgency,
[Pushover][] is used. (If Pushover being unavailable, email
notifications will be sent as a fallback.)

  [Fail2Ban]: <https://github.com/fail2ban/fail2ban>
  [logrotate]: <https://linux.die.net/man/8/logrotate>
  [Logwatch]: <https://sourceforge.net/projects/logwatch/>
  [Monit]: <https://mmonit.com/monit/>
  [Prometheus Node Exporter]: <https://github.com/prometheus/node_exporter>
  [Pushover]: <https://pushover.net/>


## Configuration and usage

See *defaults/main.yml* for all role variables. For example usage, see
the *playbook-provision.yml* playbook at the project root.
