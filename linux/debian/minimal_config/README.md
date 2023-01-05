# Debian Server Configuration

## Table of Contents

- [Requirements](#requirements)
- [Installing needed packages](#installing-needed-packages)
- [Configuring a static IP address](#configuring-a-static-ip-address)
- [Update your Debian installation](#update-your-debian-installation)
- [Configuring SSH](#configuring-ssh)

## Requirements

- Linux computer with at least 8 GB memory
- Virtual Box with Debian installed on it. (I used the netinst.iso)
- Internet

> Set the Virtual Machines network adapter to "Bridged Adapter"

## Installing needed packages

It is important to use the `su -` command meaning `"su --login"`. The command initializes the PATH variable correctly for the root user.

```shell
# su -i
```

**Update**

```shell
$ apt update
$ apt upgrade
```

**Installing sudo**

```shell
$ apt install sudo
```

**Additional packages**

```shell
$ apt install vim 
```

## Configuring a static IP address

Debian''s network is configured with DHCP as default. That's why we need to configure static IP addresses for the server. I will use the IP 192.168.43.30 for the machine.

**Check your current IP:**

```shell
$ ip a
```

**Install net tools:**

```shell
$ apt install net-tools
```

**Checking the hosts default gateway**

Open your terminal in your host Linux machine:

```shell
$ ip r | grep default
```

**Configuring the IP:**

```shell
$ vim /etc/network/interfaces
```

Change it like this: (Change gateway and enp0s3 to your needs)

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto enp0s3
iface enp0s3 inet static
        address 192.168.43.30
        netmask 255.255.255.0
        network 192.168.43.0
        broadcast 192.168.43.255
        gateway 192.168.43.1

# This is an autoconfigured IPv6 interface
iface enp0s3 inet6 auto
```

Restart your network:

```shell
$ systemctl restart networking
```

Edit **/etc/hosts**:

```shell
vim /etc/hosts
```

```
127.0.0.1       localhost.localdomain   localhost
192.168.43.30   server1.example.com     server1

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

Now edit the hostname in case you did not match it according to the server name: ("server1")

```shell
$ vim /etc/hostname
```

```
server1
```

Reboot the server:

```shell
$ systemctl reboot
```

## Update your Debian installation

```shell
vim /etc/apt/sources.list
```

```shell
# deb cdrom:[Debian GNU/Linux 11.0.0 _Bullseye_ - Official amd64 NETINST 20210814-10:07]/ bullseye main

#deb cdrom:[Debian GNU/Linux 11.0.0 _Bullseye_ - Official amd64 NETINST 20210814-10:07]/ bullseye main

deb http://deb.debian.org/debian/ bullseye main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye main contrib non-free

deb http://security.debian.org/debian-security bullseye-security main contrib non-free
deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free

# bullseye-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye-updates main contrib non-free

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching "deb cdrom"
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual.
```

Run

```shell
$ apt update
```

To update the apt package database and

```shell
$ apt upgrade
```

to install the latest updates.

## Configuring SSH

If you haven't already installed ssh, install it:

```shell
$ sudo apt install openssh-server
```

Check the status of ssh

```shell
$ sudo systemctl status ssh
```

If ssh is inactive and disabled:

```shell
$ sudo systemctl enable ssh --now
```

> **Note:** the --now tells the system to start and enable the service at the same time.

**Open SSH port in a firewall**

If you have a firewall enabled in Virtual Box, it could block the ssh connection.

Check open ports:

```shell
sudo lsof -i -P -n | grep LISTEN
```

If the port 22 is not there, open it in your firewall:

```shell
$ sudo ufw allow ssh
$ sudo ufw status verbose
```

**Connect to ssh using a different port:**

```shell
ssh -p 500 root@192.168.1.2
```
