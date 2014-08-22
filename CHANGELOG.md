# 0.2.0 (unreleased)

Breaking Changes:

* Default listen location changed from `http://FQDN:3000` -> `http://localhost:8082`

New Features:

* Includes an LWRP. You can now define checks with `uptime_check`

# 0.1.0

Initial release of uptime

* Features
  * Installs app from github source
  * Installs npm
  * Installs mongodb
  * Runs app as Upstart service for ubuntu
