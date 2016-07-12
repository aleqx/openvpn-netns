openvpn-netns
=============

Start OpenVPN connection inside Linux network namespace.

These scripts allow some programs to use the VPN connection while the
rest of the system uses the normal network connection. For programs
inside the namespace, the only network connection to the outside world
is through the VPN tunnel. This prevents VPN leaks. Multiple VPN
connections can be opened at the same time each in its separate
namespace.


Scripts
-------

### `openvpn-netns`

Start OpenVPN connection in namespace. Must be started as root.

Usage: `sudo openvpn-netns <openvpn-args> ...`


### `openvpn-netns-shell`

Start OpenVPN connection and run shell or command in namespace. When
the command terminates, the OpenVPN connection is closed. Requires
[netns-exec]. Doesn't need to be started as root; calls sudo
internally.

Start shell: `openvpn-netns-shell <openvpn-args> ...`

Start command: `openvpn-netns-shell <openvpn-args> ... -- <command> [<args> ...]`


### `openvpn-scripts/netns`

OpenVPN up/route-up/down script that contains the actual netns
handling. Requires root privileges. The above scripts call OpenVPN
with this script. To use it directly, start OpenVPN as follows:

    openvpn --ifconfig-noexec --route-noexec --script-security 2 \
        --setenv NETNS "<netns-name>" \
        --up openvpn-scripts/netns \
        --route-up openvpn-scripts/netns \
        --down openvpn-scripts/netns \
        ...


Settings
--------

For all these sripts, network namespace is given in environment
variable `NETNS`. If the environment variable is unset or null,
namespace `vpn` is used. If the namespace doesn't exist, it is
automatically created when the connection is started and deleted when
the connection is terminated. Note that sudo doesn't usually pass all
environment variables to the command; instead, use `sudo env
NETNS="<netns>" ...`.

Normally, DNS settings received from OpenVPN server are used inside
the namespace. To override them, create file
`/etc/netns/$NETNS/resolv.conf`, which will be bind mounted into
`/etc/resolv.conf` inside the namespace (see `man ip-netns`). If the
file doesn't exist, it is automatically generated from DNS settings
from the server when the connection is started and deleted when the
connection is terminated.


Installing
----------

    sudo ln -s "$PWD"/openvpn-netns /usr/local/bin/openvpn-netns
    sudo ln -s "$PWD"/openvpn-netns-shell /usr/local/bin/openvpn-netns-shell


[netns-exec]: https://github.com/pekman/netns-exec