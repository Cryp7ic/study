# Linux Cheat Sheet

- [Basic administration commands](#Basic\administration\commands)
- [Users](#users)
  - [User data](#user\data)
  - [User passwords](#user\passwords)
  - [User groups](#user\groups)
- [Files](#files)
  - [Managing files and folders](#managing\files\and\folders)
  - [Compression](#Compression)
  - [Downloading files](#Downloading\files)
  - [Transferring files](#Transferring\files)
  - [File and folder permissions](#file\and\folder\permissions)
  - [Special permissions](#special\permissions)
  - [File and folder ownership](#file\and\folder\ownership)
- [Disks](#disks)
  - [Partition creation](#partition\creation)
  - [Swap area](#swap\area)
  - [Partition mounting](#partition\mounting)
  - [Automating mounting](#automating\mounting)
  - [Crontab](#Crontab)
- [Networking](#Networking)
- [System resource management](#System\resource\management)
- [Environment variable](#Environment\variable)
- [Device information](#Device\information)
  - [Kernel information and module management](#Kernel\information\and\module\management)
  - [Hardware information](#Hardware\information)
- [Linux server](#Linux\server)
  - [Python http server](#Python\http\server)
  - [Useful Linux server commands](#Useful\Linux\server\commands)


## Basic administration commands
Reboot the system

```sh
reboot
```

Shut down the system

```sh
poweroff
```

Synchronize the changes of one directory to another

```sh
rsync
```

View the contents of a file

```sh
cat <filename>
```

Quickly find a file or directory that has been cached

```sh
locate <filename>
```

## Users

Login via ssh

```sh
ssh username@address
ssh -l username address
```

Become root

```sh
sudo -i
# OR
su
```

To check your user

```sh
whoami
```

To switch your user

```sh
su - <username>
```


### User data

Creating a user

```sh
adduser <username>
```

Check user creation outcome: shows user ID, group ID and list of user groups

```sh
id <username>
```

User IDs

- `0` is reserved for `root`
- `0 - 99` are for system Users
- `199 - 999` are for special use / system users
- `1000 - ...` are for ordinary users

Get user's default shell

```sh
getent passwd <username>
```

Modify user data using `usermod` and parameters

```sh
usermod -s /bin/dash <username>
```

Removing a user

```sh
deluser --remove-home <username>
```


### User passwords

Check account password status. `L` stands for locked. `P` shows enabled.

```sh
passwd -S <username>
```

Lock a user's account

```sh
passwd -l <username>
# Display
passwd: password expiry infoamtion changed.
```

Unlocking a user

```sh
passwd -u <username>
```


### User groups

Creating a group

```sh
addgroup <groupname>
```

Check if a group has been made

``` sh
grep <group> /etc/passwd
```

List all members of a group

```sh
getent group <groupname>
```

Add a user to a group using adduser

```sh
adduser <username> <groupname>
```

Add a user to a group using usermod

``` sh
usermod -a -G <groupname> <username>
```

Add a user to multiple groups at once

``` sh
usermod -a -G <groupname>,<groupname2 <username>
```

Adding users to sudo group

``` sh
usermod -aG sudo <username>
```

Viewing an user's groups

```sh
id <username>
# OR
groups <username>
```

Removing users from a group

```sh
deluser <username> <groupname>
```

Removing a group

```sh
delgroup <groupname>
```

Listing all existing groups

``` sh
less /etc/group
```


## Files

To get more info about a command

```sh
man <commandname>
```


### Managing files and folders

Copy

``` sh
cp <source> <destination>
```

Move

``` sh
mv <source> <destination>
```

Create a folder

```sh
mkdir <path/foldername>

# For root folders:
mkdir /foldername
```

Remove a folder

```sh
rmdir <folder>
```

Create a file

``` sh
touch <text.txt>
```

Remove a file

``` sh
rm <text.txt>
```

Remove a directory that is not empty

```sh
rm -r <filename>
```


Find and filter files

```sh
find <path> -name '*<match>*' 2>/dev/null
# 2>/dev/null discards error messages
# use / as path for global search
```

To find and move

```bash
find <path> -name '*<match>*' -exec mv {} <dest_path> \;
```


### Compression

Create an uncompressed tar archive

```sh
tar cf <dir>.tar <dir>
```

Create a tar archive with gzip compression

```sh
tar cfz <dir>.tar <dir>
```

Compress a file with gzip compression

```sh
gzip <file>
```

Extract the contents of any type of tar archive

```sh
tar xf <file>
```

Decompress a file that has gzip compression

```sh
gunzip <file>.gz
```

Decompress a file that has zip compression

```sh
unzip <file>.zip
```


### Downloading files

Download files from the web via HTTP wget

```sh
wget <URL>
```


### Transferring files

Transfer data from any server over to your computer

```sh
curl <siteURL/filename>
or
curl -I <subdomain.maindomain.topleveldomain>
```

Store cookies using curl

```sh
curl --cookie <filename> <URL>
```

Copy files & directories from your current system to a remote system (ssh)

```sh
scp important.txt ubuntu@192.168.1.30:/home/ubuntu/transferred.txt
```

Copy files & directories from a remote system to your current system (ssh)

```sh
scp ubuntu@192.168.1.30:/home/ubuntu/documents.txt notes.txt
```

Transferring files with FTP

```sh
sftp <username>@<ipaddress>
```

Send emails from your terminal with `sendmail`

```sh
echo <"subject: new" | sendmail name@address.com < mail.txt>
```

Display email statistics for Linux email servers

```sh
mailstats -p
mailstats -f <file>
```


### File and folder permissions

Manage file folder permissions

```sh
chmod <permsint> <target>

# Numerical
chmod ___ <target>

# Alphabetical, - for removing, + for adding
chmod u_, g_, o_
# u-users, g-groups, o-others

# r-read, w-write, x-execute
chmod _+r <target>
```

Creating a script

```sh
nano <path/filename>.sh
```

Example of a backup script

```bash
#!/bin/bash
echo "Copy original files to backup folder"
cp -aR /uploads / backup
cp -aR /etc /backup
echo "Create a tar archive of backed up files
tar -czvf uploads backup_backup.tar.gz /backup/uploads > /dev/null 2>&1
tar -czvf etc_backup.tar.gz /backup/etc > /dev/null 2>&1
```


### Special permissions

- **sticky bit**: used in `/tmp` so that all users can save files, but only owner can delete the file | `o+t` or `1`
- **setUID bit**: can oly be set on a file, and if the file can be executed as root, then all users can execute it as root | `u+s` or `4`
- **setGID bit**: can be set on files and folders and causes group permission inheritance | `g+s` or `2`

Changing group of a folder and subfolders

```Note: -R will change all the subfolders within the folder.```

```sh
chgrp <groupname> <path> -R
```

Finding files with permissions

```sh
find <path> -perms <permsint> 2>dev/null
# For setUID: 4755
# For sticky: 1777
```


### File and folder ownership

Change owner of a file / folder

```sh
chown <username> <path> [-R]
# R stands for recursive for groups
```

Change group of a file / folder

```sh
chgrp <groupname> <path> [-R]
```


## Disks

To display all existing block devices

```sh
lsblk
```

To list all disks

``` sh
fdisk -l
```

To _select_ a disk

```sh
fdisk [disk]
```


### Partition creation

- `n` option for new partition
- `w` option for writing and exiting

### Swap area

Creating a new swap area

```sh
mkswap <device>
```

Enabling or disabling swap area

```sh
swapon
wapoff
# -s shows target areas
# -a selects all areas
```

Changing permanent swappiness setting

```sh
sysctl vm.swappiness
```

Swappiness settings can be checked with

```sh
cat /proc/sys/vm/swappiness
```

Making changes permanent

```sh
sysctl vm.swappiness=<option> >> /etc/sysctl.conf
```

Checking permanent changes

```sh
cat /etc/sysctl.conf | grep swap
```


### Partition mounting

Creating a file system on a disk

```sh
mkfs
# Use -t to specify the filesystem
# OR
mkfs.<filesystem> <device>
```

Getting info about formatted partitions

```sh
blkid
# OR
lsblk -f
```

Mounting and unmounting partitions

```sh
mount
unmount
# use {name1, name2, ...} to specify folders to mount / unmount
```

Displaying all mounted partitions

```sh
df -h
```


### Automating mounting

Adding UUIDs to `fstab` for mount on boot

```sh
blkid | grep <partition> >> /etc/fstab
nano /etc/fstab
# Then, comment out unnecessary info
```

`fstab` for swap

```sh
<filesystem>  <mountpoint> <type> <options> <dump> <pass>
UUID=... none swap sw 0 0
```

`fstab` for regular partitions

```sh
UUID=... /mnt/<mountpoint> {ext4 | ntfs} defaults 0 2
```

`fstab` without the UUID

``` sh
nano /etc/fstab
/dev/sdb1 /mnt/drive ext4 defaults 0 0
```


## Crontab
```sh
crontab <options>
* * * * * <command>
or
* * * * * <path/to/script>
m h dom mon dow
# month hour day(1-31) month(1-12) day(0-6)  
```


## Networking

Manage network devices, tunnels, routing, etc

```sh
ip addr
ip link
ip addr <add 192.168.1.xxx/24 dev eth0>
```

Show IP address and other information for all active interfaces

```sh
ip a
```

Show IP address of default gateway

```sh
ip r
```

See what DNS servers your system is configured to use

```sh
cat /etc/resolv.conf
```

Ping

```sh
ping <address>
```

Trace the network path taken to a device

```sh
traceroute <option> <address> <packet_len>
```

View network interfaces and assign, add, delete, or control interface parameters.

```sh
ifconfig

ifconfig | grep inet
```

Configure wireless interfaces

```sh
iwconfig
```

Restrict or block IPs

```sh
iptables
```

Monitor incoming and outgoing network traffics

```sh
nload
nload devices <wlp1s0>
```

Monitor the IP address, subnet, gateway, etc related to a DNS server

```sh
dhclient eth0
```


## System resource management

See how much memory is in use and free

```sh
free -m
```

See a list of processes and their resource usage

```sh
top
```

A more human readable and interactive version of top

```sh
htop
```

Start a new process with a specified priority

```sh
nice
```

Change the nice value of a currently

```sh
renice
```

View all of the currently 

```sh
ps aux OR ps -ef
```

Terminate a process 

```sh
kill or killall
```

Terminate a process with SIGKILL signal

```sh
kill -9 or killall -9
```

Send a task to the background

```sh
bg
```

Bring a task to the foreground

```sh
fg
```


## Environment variable

List all environment variables on a Linux system, or a specific one

```sh
printenv or printenv <variable_name>
```

Find where a command in PATH is located

```sh
whereis and which
```

Set a temporary environment variable

```sh
export <MY_SITE="linuxconfig.org">
```

Display the value of a variable

```sh
echo $VARIABLE
```

Remove a variable

```sh
unset
```


## Device Information

### Kernel information and module management

Output detailed information about your kernel version and architecture

```sh
uname -a
```

Find what modules are currently loaded

```sh
lsmod
```

Get information about any particular module

```sh
modinfo <modulename>
```

Remove a module

```sh
modprobe --remove <modulename>
```

Load a module into the kernel

```sh
modprobe <modulename>
```


### Hardware information

See general information about host bridge, VGA controller, ethernet controller, USB controller, SATA controller, etc.

```sh
lspci
```

See some info about BIOS, motherboard, chassis, etc.

```sh
dmidecode
```

Retrieve processor type, socket, speed, configured flags, etc.

```sh
cat /proc/cpuinfo
```

See information about the CPU

```sh
x86info or x86info -a
```

See detailed information about system RAM

```sh
cat /proc/meminfo
```

List all hardware components and see their configuration details

```sh
lshw
```

Detect number of RAM slots used, speed and size

```sh
lshw -C memory -short
```

List details for all hardware, including their device files and config options

```sh
hwinfo
```

Get some general information about your system's BIOS

```sh
biosdecode
```

Retrieve the name of your BIOS vendor

```sh
dmidecode -s bios-vendor
```

Get a list of USB device files

```sh
ls -la /dev/disk/by-id/usb-*
```

Get info about your hard drive's make, model, serial number, firmware version, and config

```sh
hdparm -I /dev/sdx
```

Show the speed of an installed hard drive - including cached reads and buffered disk reads

```sh
hdparm -tT /dev/sdx
```

Locate CD or DVD device file

```sh
wodim --devices
```

## Linux server

### Python http server

Importing Python httpserver module

```sh
import http.server
```

Run the Http Server

```sh
# Starting the local http server at port 8000
python3 -m http.server 8000
```

>1. Find out the server IP address using `ip -a | grep`.
>2. From the remote client, type `http://<ipaddress>:8000/` on your browser.


### Useful Linux server commands

Display the system running time

```sh
uptime

# -p tells the system uptime in an easily readable format.
uptime -p
```

Display all the users logged in to a system and their activities

```sh
w
# -s displays a shortlist, ommiting CPU time and login information
w -s 
# -i, to print out the IP of the remote hosts
ww -i
```

Display information about remote users.

```sh
who
# -b to print when the system was booted
who -b
# -d to show the dead processes
who -d
# --ips to print out the IP of the remote host
who --ips
```

Users

```sh
users

users --version

users --help
```

Scroll through massive files very quickly

```sh
more </var/log/custom.log>

more -h

man more
```

Debugging through log files very fast.

```sh
tail </var/log/custom.log>

# -f enables admins to follow their logs as they're written
tail -f </var/log/custom.log>
```

Find domain-specific information

```sh
dig <domain.com>
```

Query DNS servers and grab essential information regarding remote servers.

```sh
nslookup <domain.com>
```

View all active TCP connections, socket states, routing tables, etc.

```sh
netstat

netstat -l

netstat -a | more
```

Check whether your server is rightly protected by SELinux or not

```sh
sestatus
```

Monitor the performance of the server

```sh
dstat 
fstat -c --top-cpu --top-mem
```

Get a detailed visualization of your network statistics

```sh
# Excellent for socket dumping
ss
ss -lt
ss -p
```

`mtr`, ping and traceroute command in a single program

```sh
mtr
mtr --report
```

Check the available and occupied memory of your server

```sh
free
free -m
```

Monitor disk space information

```sh
# df - de-facto
df -a
df -h
df -T
```

`htop`

`ps`

Check active environment variables and run programs in a modified system environment

```sh
env
```

Display all currently open files alongside the processes that opened them

```sh
lsof
```