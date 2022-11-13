Check if port forwarding is enabled in Linux

```sh
sysctl -a | grep -i wlan0.forwarding
# 0 - indicated that port forwarding is disabled.
```

or you can use the process filesystem to check if port forwarding is enabled or not

```sh
cat /proc/sys/net/ipv4/conf/wlan0/forwarding
cat /proc/sys/net/ipv6/conf/wlan0/forwarding
```

Enabling port forwarding in Linux using `sysctl` command

```sh
sysctl net.ipv4.conf.wlan0.forwarding=1
sysctl net.ipv6.conf.wlan0.forwarding=1
```

To make persistent over reboots, add parameters in `/etc/sysctl.conf`

```sh
echo "net.ipv4.conf.wlan0.forwarding = 1">>/etc/sysctl.conf
echo "net.ipv6.conf.wlan0.forwarding = 1">>/etc/sysctl.conf
sysctl -p
```

Now, we have port forwarding enabled on our server, we can go ahead with configuring port forwarding rules using `iptables`.

### How to forward port in Linux
Here we will forward port 80 to port 8080 on 172.31.40.29. Do not get confused port forwarding with `port redirection`.

We need to insert an entry in `PREROUTING` chain of `iptables` with `DNAT` target. Command will be as follows 

```sh
iptables -A PREROUTING -t nat -i wlan0 -p tcp --dport 80 -j DNAT --to 172.31.40.29:8080
iptables -A FORWARD -p tcp -d 172.31.40.29 --dport 8080 -j ACCEPT
```

Change interface, IP and ports as per your requirement. The first command tells us to redirect packets coming to port 80 to IP 172.31.40.29 on port 8080. Now packet also needs to go through `FORWARD` chain so we are allowing in in the second command.

Now rules have been applied. You need to verify them.

### How to check port forwarding iptables rules
Command to verify port forwarding rules is

```sh
iptables -t nat -L -n -v
```

Here `REDIRECT` target means its a redirection rule. Since we have configured forwarding rule we see the target as `DNAT`.

### How to save iptables rules
To save `iptables` rules and make them persistent over reboots use below command 

```sh
iptables-save
```
