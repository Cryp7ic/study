## VLAN
**Switch**
switch(config)#vlan 2
switch(config-vlan)#name (name)
switch(config-vlan)#vlan 3
switch(config-vlan)#name (name)
switch(config-vlan)#vlan 4
switch(config-vlan)#name (name)

interface fa0/0
interface range fa0/1-4

switchport mode access (Arvutid)
switchport mode trunk (ruuterid)
switchport trunk allowed vlan 1-10

switchport access vlan 10
switchport trunk native vlan 10

  
**ROUTER**
Router(config)#interface fastEthernet 0/0.2
Router(config-subif)#encapsulation dot1Q 2
Router(config-subif)#ip address (ip add) (subnet mask)


## CLIENT/SERVER
**SWITCH**

vtp domain (name)
vtp mode server / vtp mode client

  
  

## SSH
interface fa0/0
R1(config-if)#ip address (ip add)(subnet mask)
R1(config-if)#no shutdown

(Config)

host L3

ip domain-name test

username admin privilege 15 secret admin

crypto key generate rsa

1024

ip ssh version 2

line vty 0 15/line vty 0 4

login local

transport input ssh

SSH Katkestamine mingil kindlal vlanil.

line vty 0 15

access-class 1 in/access-list 1 deny (network&wildcard)

access-list 1 permit any

## DHCP
**ROUTER**

Int Fa0/0

Ip address (default gateway ip add) 

No shutdown

ip dhcp pool (name)
RouterA(dhcp-config)# network (ip add)(subnet mask)
RouterA(dhcp-config)# default-router (default gateway ip add)

RouterA(dhcp-config)# exit

ip dhcp excluded-address (IP)

dns-server (DNS IP)

ip helper-address (ip add)

int fa0/0
ip add dhcp
no shut

## AAA

aaa new-model

username (name) password (password)rout

enable password (password)

aaa authentication login myauth group tacacs+/radius local

interface Vlan 2

ip address 

exit

line vty 0 4

login authentication (name)

## IP ROUTE
**ROUTER**

ip route (network) (subnet mask) (router ip add)


## SNMP

snmp-server community (name) ro
snmp-server community (name)rw rw


## NAT
**ROUTER**

NAT Static
int fa0/0
ip nat inside
int fa1/0
ip nat outside

exit

ip nat inside source static (seadme inside ip add) (free inside ip add/seadme uus ip add)

## NAT Dynamic
int fa0/0
ip nat inside
int fa1/0
ip nat outside
ip nat inside source static (point inside a to outside b ip add) 
ip nat pool (name)1 (outside ip add) (outside free ip add) netmask (subnet mask)
access-list 1 permit (inside network ip add) 0.0.0.255
ip nat inside source list 1 pool (list name)1


## PAT (natil ei ole access-groupi vaja)

int fa0/0
ip nat inside
int fa1/0
ip nat outside
access-list 1 permit (inside network ip add) 0.0.0.255
rule:
ip nat inside source list 1 int fa0/0 overload - välimine port
või:
ip access-list standard for_nat 
permit 10.0.1.0 0.0.0.31
deny any
ip nat inside source list for_nat int fa0/0 overload - välimine port

  
## MULTILAYER SWITCH

Switch MLS_1
Adding VLAN

MLS_1(config)#vlan 10
MLS_1(config-vlan)#vlan 20
MLS_1(config-vlan)#vlan 30

**Configuring Trunk**

MLS_1(config)#interface fastEthernet 0/1
MLS_1(config-if)#switchport trunk encapsulation dot1q
MLS_1(config-if)#switchport mode trunk

MLS_1(config-if)#interface fastEthernet 0/2
MLS_1(config-if)#switchport trunk encapsulation dot1q
MLS_1(config-if)#switchport mode trunk

MLS_1(config-if)#interface fastEthernet 0/3
MLS_1(config-if)#switchport trunk encapsulation dot1q
MLS_1(config-if)#switchport mode trunk

**Assign VLAN into Interfaces**

MLS_1(config)#interface vlan 10
MLS_1(config-if)#ip address 192.168.1.1 255.255.255.0

MLS_1(config-if)#interface vlan 20
MLS_1(config-if)#ip address 192.168.2.1 255.255.255.0

MLS_1(config-if)#interface vlan 30
MLS_1(config-if)#ip address 192.168.3.1 255.255.255.0

**Enable routing on Multilayer Switch**

MLS_1(config)#ip routing

**Switch SW_1**

**Configuring Trunk**

SW_1(config)#interface fastEthernet 0/1
SW_1(config-if)#switchport mode trunk

**Adding VLAN**

SW_1(config)#vlan 10
SW_1(config-vlan)#vlan 20
SW_1(config-vlan)#vlan 30

**Assign VLAN to Interfaces**

  

SW_1(config)#interface fastEthernet 0/2
SW_1(config-if)#switchport mode access
SW_1(config-if)#switchport access vlan 20

SW_1(config-if)#interface fastEthernet 0/3
SW_1(config-if)#switchport mode access
SW_1(config-if)#switchport access vlan 30

## Access-lists (ACL)

**Et vlan 11 ei saaks ligipääsu vlan 12-le**
access-list 1 deny 10.0.1.8 0.0.0.7
access-list 1 permit any
ip access-group 1 in

**More Access List:

**Extended :**
ip access-list extended ‘servers’
?
deny ip 10.0.1.0 0.0.0.255 host 8.8.8.8
ip access-group ‘servers’ in/out

ip access-list extended ‘servers’
permit ..

no switchport
ip routing

**ainult vlan x tohib ssh kasutada:**

ip access-list standard for_ssh 
permit 10.0.1.8 0.0.0.3
deny any
line vty 0 15
access-class for_ssh in

**dhcp ei tohi välisvõrku saada:
ruuter:**
ip access-list standard for_dhcp
demy host 10.0.1.6
permit any
int gi0/1
ip access-group for_dhcp in

  

**Et vlan x ei saaks ühendust dnsiga:**
ip access-list extended server_control
deny ip 10.0.1.9 0.0.0.3 host 8.8.8.8 
20 permit ip any any
int gi0/1
ip access-group server_control

**luban arvutitel ainult DNS trafficut DNS serveriga:**
9 permit udp 10.0.1.0 0.0.0.31 host 8.8.8.8 eq 53
deny ip 10.0.1.0 0.0.0.31 host 8.8.8.8

**Vlan 10 tohib hallata.**
ip access-list standard management_control
permit 10.0.10.0 0.0.0.7
deny any
**Vlan 13 on haldus vlan**
int vlan 13
ip access-group management_control in

**DHCP/DNS serverit ei tohi pingida(koik muu traffic lubatud)**
ip access-list extended server_control
deny icmp any host 10.0.12.2 echo
permit ip any any
int vlan 12
ip access-group server_control out
ip access-group server_control in

**Et serverid ei saaks arvuteid pingida:**
10.0.10-11.0-7
15 deny icmp 10.0.12.0 0.0.0.7 10.0 0.0.1.7 echo

**Extended IP access list web_server (http/https traffic)**
10 permit tcp any host 203.0.113.3 eq www
20 permit tcp any host 203.0.113.3 eq 443
30 deny ip any host 203.0.113.3
40 permit ip any any (11 match(es))

**Extended IP access list for_dmz**
10 permit icmp 10.0.10.0 0.0.0.255 10.0.1.0 0.0.0.255 echo-reply
15 permit ip 10.0.10.0 0.0.0.255 host 10.0.1.2
20 deny icmp 10.0.10.0 0.0.0.255 10.0.1.0 0.0.0.255 echo

**Keelata VLAN10 juurdepääsu VLAN13**
ip access-list extended for_vlan10
deny ip 10.0.10.0 0.0.0.255 10.0.13.0 0.0.0.255
permit ip any any
int gi0/0/0.10
ip access-group for_vlan10 in

**Kuidas teha ruuteris HTTP server?**
ip http server (paneb serveri toole)
ip authentication local (soovituslik, kasutada lokaalset kasutajat serveri sisselogimiseks)
kui teete sisselogimis võimaluse, siis peab ka kasutajat looma.)