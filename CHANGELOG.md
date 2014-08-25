# 0.2.1

Features:

* Arbitrary config options are now supported under `node['app_uptime']['config']` - plugins can now be configured under here.

Bugfixes:

* The `uptime_check` resource now correctly checks for modifications, only updating if required
* Removed an example test lwrp usage from the default recipe

# 0.2.0

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
