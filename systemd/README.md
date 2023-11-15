# Services (systemd)

`setup_services` script can be used to setup `systemd` services from the current directory.
The directory structure is as follows:
- `sbin/` - Contains scripts that serve as service targets. Symlinked to `/usr/sbin`.
- `system/` - Contains system-wide services. Symlinked to `/etc/systemd/system`.
- `user/` - Contains user services. Symlinked to `/etc/systemd/user`.
- `./enabled-system-services.txt` - A list of system services to enable.
- `./enabled-user-services.txt` - A list of user services to enable.

