# Wireshark

## Table of Contents

- [Changing Your Column Display](#changing-your-column-display)
- [Display Filter Expressions](#display-filter-expressions)
- [Identifying Hosts and Users](#identifying-hosts-and-users)
- [Examining Trickbot Infections](#examining-trickbot-infections)
- [Examining Ursnif Infections](#examining-ursnif-infections)
- [Examining Qakbot Infections](#examining-qakbot-infections)
- [Decrypting HTTPS Traffic](#decrypting-https-traffic)
- [Examining Dridex Infection Traffic](#examining-dridex-infection-traffic)
- [Examining Emotet Infection Traffic](#examining-emotet-infection-traffic)
- [Decrypting RDP Traffic](#decrypting-rdp-traffic)
- [Examining Traffic from Hancitor Infections](#examining-traffic-from-hancitor-infections)

### Changing Your Column Display

[Wireshark](https://www.wireshark.org/) is a free protocol analyzer that can record and display packet captures (pcaps) of network traffic. This tool is used by IT professionals to investigate a wide  range of network issues. As a Threat Intelligence Analyst for Palo Alto  Networks Unit 42, I often use Wireshark to review traffic generated from malware samples.
 What makes Wireshark so useful? It is very customizable. The default  column display in Wireshark provides a wealth of information, but you  should customize Wireshark to better meet your specific needs. This blog provides customization options helpful for security professionals  investigating malicious network traffic.
 A pcap for this tutorial is available [here](https://www.malware-traffic-analysis.net/training/index.html). Keep in mind you must understand network traffic fundamentals to  effectively use Wireshark. This tutorial uses version 2.6 of Wireshark  and covers the following areas:

- Web traffic and the default Wireshark column display
- Hiding columns
- Removing columns
- Adding columns
- Changing time to UTC
- Custom columns

Web Traffic and the Default Wireshark Column Display
 Malware distribution frequently occurs through web traffic, and we also  see this channel used for data exfiltration and command and control  activity. Wireshark's default column is not ideal when investigating  such malware-based infection traffic. However, Wireshark can be  customized to provide a better view of the activity.
 ![wireshark_1](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_1.png)

*Figure 1: Viewing a pcap using Wireshark's default column display.*

Wireshark's default columns are:

- **No**. -Frame number from the beginning of the pcap. The first frame is always 1.
- **Time** - Seconds broken down to the nanosecond from the first frame of the pcap. The first frame is always 0.000000.
- **Source** - Source address, commonly an IPv4, IPv6, or Ethernet address.
- **Destination** - Destination address, commonly an IPv4, IPv6, or Ethernet address.
- **Protocol** - Protocol used in the Ethernet frame, IP packet, or TCP segment (ARP, DNS, TCP, HTTP, etc.).
- **Length** - Length of the frame in bytes.

In my day-to-day work, I require the following columns in my Wireshark display:

- Date & time in UTC
- Source IP and source port
- Destination IP and destination port
- HTTP host
- HTTPS server
- Info

How can we reach this state? First, we hide or remove the columns we do not want.

Hiding Columns
 We can easily hide columns in case we need them later. Right-click on  any of the column headers to bring up the column header menu. Then  left-click any of the listed columns to uncheck them. Figure 2 shows the **No.**, **Protocol**, and **Length** columns unchecked and hidden.
 ![wireshark_2](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_2.png)

*Figure 2: Before and after shots of the column header menu when hiding columns.*

Removing Columns
 Because I never use the **No.**, **Protocol**, or **Length** columns, I completely remove them. To remove columns, right-click on  the column headers you want to remove. Then select "Remove this  Column..." from the column header menu.
 ![wireshark_3](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_3.png)

*Figure 3: Before and after shots of the column header menu when removing columns.*

At this point, whether hidden or removed, the only visible columns are Time, Source, Destination, and Info.

Adding Columns
 To add columns in Wireshark, use the Column Preferences menu.  Right-click on any of the column headers, then select "Column  Preferences..."
 ![wireshark_4](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_4.png)

*Figure 4: Getting to the Column Preferences menu by right-clicking on the column headers.*

The Column Preferences menu lists all columns, viewed or hidden. Near the bottom left side of the Column Preferences menu are two buttons.  One has a plus sign to add columns. The other has a minus sign to remove columns. Left-click on the plus sign. An entry titled "New Column"  should appear at the bottom of the column list.
 ![wireshark_5](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_5.png)

*Figure 5: Adding a new column in the Column Preferences menu.*

Double-click on the "New Column" and rename it as "Source Port." The  column type for any new columns always shows "Number." Double-click on  "Number" to bring up a menu, then scroll to "Src port (unresolved)" and  select that for the column type.
 ![wireshark_6](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_6.png)

*Figure 6: Changing the column title.*

![wireshark_7](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_7.png)

*Figure 7: Changing the column type.*

Our new column is now named "Source Port" with a column type of "Src  port (unresolved)." Left-click on that entry and drag it to a position  immediately after the source address.

![wireshark_8](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_8.png)

*Figure 8: Changing the column position.*

After the source port has been, add another column titled "Destination Port" with the column type "Dest port (unresolved)."
 ![wireshark_9](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_9.png)

*Figure 9: Adding another column for Destination Port.*

Like we did with the source port column, drag the destination port to place it immediately after the Destination address. When you finish,  your columns should appear as shown in Figure 10.

![wireshark_10](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_10.png)

*Figure 10: Final setup in the Column Preferences window.*

After adding the source and destination port columns, click the "OK"  button to apply the changes. These new columns are automatically aligned to the right, so right-click on each column header to align them to the left, so they match the other columns.

![wireshark_11](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_11.png)

*Figure 11: Aligning column displays in Wireshark.*

![wireshark_12](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_12.png)

*Figure 12: Column display after adding and aligning the source and destination ports.*

In my day-to-day work, I often hide the source address and source port columns until I need them.

Changing Time to UTC
 To change the time display format, go the "View" menu, maneuver to "Time Display Format," and change the value from "Seconds Since Beginning of  Capture" to "UTC Date and Time of Day." Use the same menu path to change the resolution from "Automatic" to "Seconds." Figure 13 shows the menu  paths for these options.
 ![wireshark_13](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_13.png)

*Figure 13: Changing the time display format to UTC date and time.*

![wireshark_14](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_14.png)

*Figure 14: UTC date and time as seen in updated Wireshark column display.*

Adding Custom Columns
 While we can add several different types of columns through the column  preferences menu, we cannot add every conceivable value. Fortunately,  Wireshark allows us to add custom columns based on almost any value  found in the frame details window. This is how we add domain names used  in HTTP and HTTPS traffic to our Wireshark column display.
 To quickly find domains used in HTTP traffic, use the Wireshark filter **http.request** and examine the frame details window.
 In the frame details window, expand the line titled "Hypertext Transfer  Protocol" by left clicking on the arrow that looks like a greater than  sign to make it point down. This reveals several additional lines.  Scroll down to the line starting with "Host:" to see the HTTP host name. Left click on this line to select it. Right click on the line to bring  up a menu. Near the top of this menu, select "Apply as Column." This  should create a new column with the HTTP host name.
 ![wireshark_15](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_15.png)

*Figure 15: Applying the HTTP host name as a column.*

![wireshark_16](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_16.png)

*Figure 16: HTTP host names in the column display when filtering on **http.request**.*

To find domains used in encrypted HTTPS traffic, use the Wireshark filter **ssl.handshake.type == 1** and examine the frame details window.
 In the frame details window, expand the line titled "Secure Sockets  Layer." Then expand the line for the TLS Record Layer. Below that expand another line titled "Handshake Protocol: Client Hello."
 ![wireshark_17](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_17.png)

*Figure 17: Filtering on SSL handshake type and working our way down.*

Below the "Handshake Protocol: Client Hello" line, expand the line  that starts with "Extension: server_name." Under that is "Server Name  Indication extension" which contains several Server Name value types  when expanded. Select the line that starts with "Server Name:" and apply it as a column. Figure 18 shows an example.

![wireshark_18](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_18.png)

*Figure 18: Applying the HTTPS server name as a column.*

![wireshark_19](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_19.png)

*Figure 19: HTTP server names in the column display when filtering on **ssl.handshake.type == 1**.*

With this customization, we can filter on **http.request or ssl.handshake.type == 1** as shown in Figure 20. This gives us a much better idea of web traffic  in a pcap than using the default column display in Wireshark.

![wireshark_20](https://unit42.paloaltonetworks.com/wp-content/uploads/2018/08/wireshark_20.png)

*Figure 20: Filtering on **http.request or ssl.handshake.type == 1** in the pcap for this tutorial.*

### Display Filter Expressions

As a Threat Intelligence Analyst for Palo Alto Networks Unit 42, I  often use Wireshark to review packet captures (pcaps) of network traffic generated by malware samples. To better accomplish this work, I use a  customized Wireshark column display as described [my previous blog about using Wireshark](https://blog.paloaltonetworks.com/2018/08/unit42-customizing-wireshark-changing-column-display/). Today's post provides more tips for analysts to better use Wireshark.  It covers display filter expressions I find useful in reviewing pcaps of malicious network traffic from infected Windows hosts.

Pcaps for this tutorial are available [here](https://www.malware-traffic-analysis.net/training/index.html). Keep in mind you must understand network traffic fundamentals to  effectively use Wireshark. And you should also have a basic  understanding of how malware infections occur. This is not a  comprehensive tutorial on how to analyze malicious network traffic.  Instead, it shows some tips and tricks for Wireshark filters. This  tutorial covers the following areas:

- Indicators of infection traffic
- The Wireshark display filter
- Saving your filters
- Filters for web-based infection traffic
- Filters for other types of infection traffic

**Indicators of Infection Traffic**

This tutorial uses examples of Windows infection traffic from  commodity malware distributed through mass-distribution methods like  malicious spam (malspam) or web traffic. These infections can follow  many different paths before the malware, usually a Windows executable  file, infects a Windows host.

Indicators consist of information derived from network traffic that  relates to the infection. These indicators are often referred to as  Indicators of Compromise (IOCs). Security professionals often document  indicators related to Windows infection traffic such as URLs, domain  names, IP addresses, protocols, and ports. Proper use of the Wireshark  display filter can help people quickly find these indicators.

**The Wireshark Display Filter**

Wireshark's display filter a bar located right above the column  display section. This is where you type expressions to filter the  frames, IP packets, or TCP segments that Wireshark displays from a pcap.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure1.png)*Figure 1. Location of the display filter in Wireshark.*

If you type anything in the display filter, Wireshark offers a list  of suggestions based on the text you have typed. While the display  filter bar remains red, the expression is not yet accepted. If the  display filter bar turns green, the expression has been accepted and  should work properly. If the display filter bar turns yellow, the  expression has been accepted, but it will probably not work as intended.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure2.png)*Figure 2. Wireshark's display filter offering suggestions based on what you type.*

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure3.png)*Figure 3. Wireshark's display filter accepts an expression, and it works as intended.*

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure4.png)*Figure 4. Example of Wireshark's display filter accepting an expression, but it does not work as intended.*

Wireshark's display filter uses [Boolean expressions](https://en.wikipedia.org/wiki/Boolean_expression), so you can specify values and chain them together. The following expressions are commonly used:

- Equals: ***==\*** or ***eq\***
- And: ***&&\*** or ***and\***
- Or: ***||\*** (double pipe) or ***or\***

Examples of these filter expressions follow:

- ***ip.addr eq 192.168.10.195 and ip.addr == 192.168.10.1\***
- ***http.request && ip.addr == 192.168.10.195\***
- ***http.request || http.response\***
- ***dns.qry.name contains microsoft or dns.qry.name contains windows\***

When specifying a value exclude, do not use ***!=\*** in your filter expression. For example, if you want to specify all traffic that does not include IP address 192.168.10.1, use ***!(ip.addr eq 192.168.10.1)\*** instead of ***ip.addr != 192.168.10.1\*** because that second filter expression will not work properly.

**Filters for Web-Based Infection Traffic**

I often use the following filter expression as a way to quickly review web traffic in a pcap:

***http.request or ssl.handshake.type == 1\***.

The value ***http.request\*** reveals URLs for HTTP requests, and ***ssl.handshake.type == 1\*** reveals domains names used in HTTPS or SSL/TLS traffic.

My previous tutorial contains web traffic generated when a user viewed a URL from ***college.usatoday[.]com\*** in August 2018. In the pcap, the user was on a Windows 10 computer using Microsoft's Edge web browser. Filtering on ***http.request or ssl.handshake.type == 1\*** outlines the flow of events for this web traffic.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure5.png)*Figure 5. Filtering on web traffic using the previous tutorial's pcap.*

However, I also generate pcaps of traffic using Windows 7 hosts, and  this traffic includes HTTP requests over UDP port 1900 during normal  activity. This HTTP traffic over UDP port 1900 is Simple Service  Discovery Protocol (SSDP). SSDP is a protocol used to discover Plug  & Play devices, and it is not associated with normal web traffic.  Therefore, I filter this out using the following expression:

***(http.request or ssl.handshake.type == 1) and !(udp.port eq 1900)\***

You can also use the following filter and achieve the same result:

***(http.request or ssl.handshake.type == 1) and !(ssdp)\***

Filtering out SSDP activity when reviewing a pcap from an infection  on a Windows 7 host provides a much clear view of the traffic. Figure 6  shows Emotet activity with IcedID infection traffic from December 3rd,  2018 on a Windows 7 host. It is filtered on web traffic that contains  SSDP requests. Figure 7 shows the same pcap filtered on web traffic *excluding* the SSDP requests, which provides a clearer picture of the activity.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure6.png)*Figure 6. Reviewing web traffic with Emotet and IcedID infection activity in Wireshark without filtering out SSDP traffic.*

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure7.png)*Figure 7. Reviewing web traffic with Emotet and IcedID infection activity in Wireshark while filtering out SSDP traffic.*

In Figure 7, we see some indicators of infection traffic, but not  every indicator of the infection is revealed. In some cases, an infected host may try to connect with a server that has been taken off-line or  is refusing a TCP connection. These attempted connections can be  revealed by including TCP SYN segments in your filter by adding ***tcp.flags eq 0x0002\***. Try the following filter on the same traffic:

***(http.request or ssl.handshake.type == 1\*** ***or tcp.flags eq 0x0002) and !(udp.port eq 1900)\***

Including the TCP SYN segments on your search reveals the infected  host also attempted to connect with IP address 217.164.2[.]133 over TCP  port 8443 as shown in Figure 8.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure8.png)*Figure 8. Including TCP SYN segments in your filter can reveal unsuccessful  connection attempts by an infected host to other servers.*

**Filters for Other Types of Infection Traffic**

In some cases, post-infection traffic will not be web-based, and an  infected host will contact command and control (C2) servers. These  servers can be directly hosted on IP addresses, or they can be hosted on servers using domain names. Some post-infection activity, like C2  traffic caused by the Nanocore Remote Access Tool (RAT), is not HTTP or  HTTPS/SSL/TLS traffic.

Therefore, I often add DNS activity when reviewing a pcap to see if  any of these domains are active in the traffic. This results in the  following filter expression:

***(http.request or ssl.handshake.type == 1 or tcp.flags eq\*** ***0x0002 or dns) and !(udp.port eq 1900)\***

In Figure 9, I use the above filter expression to review a pcap showing a Nanocore RAT executable file downloaded from ***www.mercedes-club-bg[.]com\*** to infect a vulnerable Windows host. The initial download is followed by attempted TCP connections to ***franex.sytes[.]net\*** at 185.163.45[.]48 and ***franexserve.duckdns[.]org\*** at 95.213.251[.]165. Figure 10 shows the correlation between the DNS queries and the TCP traffic.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure9.png)*Figure 9. Including DNS queries reveals attempted TCP connections to additional domains.*

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure10.png)*Figure 10. Correlating DNS traffic to the TCP activity.*

Some infection traffic uses common protocols that can easily be  decoded by Wireshark. Figure 11 shows post-infection traffic caused by [this malware executable](https://www.virustotal.com/#/file/d5c7ac49ea9ba23c2822b62b7acf413fb8b35ac70744a42102e000c39bac03fc/) that generates FTP traffic. Using a standard web traffic search that  also checks for DNS traffic and TCP SYN flags, we find traffic over TCP  port 21 and other TCP ports after a DNS query to ***ftp.totallyanonymous[.]com\***.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure11.png)*Figure 11. Activity from malware generating FTP traffic.*

Realizing this is FTP traffic, you can pivot on ***ftp\*** for your display filter as shown in Figure 12. When filtering on ***ftp\*** for this pcap, we find the infected Windows host logged into an FTP account at ***totallyanonymous.com\*** and retrieved files named ***fc32.exe\*** and ***o32.exe\***. Scroll down to later FTP traffic as shown in Figure 13, and you will find a file named ***6R7MELYD6\*** sent to the FTP server approximately every minute. Further investigation would reveal ***6R7MELYD6\*** contains password data stolen from the infected Windows host.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure12.png)*Figure 12. Using ftp as a filter and finding the name of files retrieved by  the infected host when viewing the FTP control channel over TCP port 21.*

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure13.png)*Figure 13. The FTP control channel over TCP port 21 also shows information stored to the FTP server as a file named 6R7MELYD6.*

In addition to FTP, malware can use other common protocols for  malicious traffic. Spambot malware can turn an infected host into a  spambot designed to send dozens to hundreds of email messages every  minute. This is characterized by several DNS requests to various mail  servers followed by SMTP traffic on TCP ports 25, 465, 587, or other TCP ports associated with email traffic.

Let's try this filter expression again:

***(http.request or ssl.handshake.type == 1 or tcp.flags eq\*** ***0x0002 or dns) and !(udp.port eq 1900)\***

When viewing spambot traffic, you'll find DNS queries to mail servers and TCP traffic to SMTP-related ports as previously described.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure14.png)*Figure 14. Wireshark filtered on spambot traffic to show DNS queries for  various mail servers and TCP SYN packets to TCP ports 465 and 587  related to SMTP traffic.*

If you use ***smtp\*** as a filter expression,  you'll find several results. In cases where you find STARTTLS, this will likely be encrypted SMTP traffic, and you will not be able to see the  email data.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure15.png)*Figure 15. Filtering on SMTP traffic in Wireshark when viewing spambot traffic.*

In recent years, email traffic from spambots is most likely encrypted SMTP. However, you might find unencrypted SMTP traffic by searching  for strings in common email header lines like:

- ***smtp contains "From: "\***
- ***smtp contains "Message-ID: "\***
- ***smtp contains "Subject: "\***

Keep in mind the Wireshark display filter is case-sensitive. When  searching spambot traffic for unencrypted SMTP communications, I often  use ***smtp contains "From: "\*** as my filter expression as shown in Figure 16.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure16.png)*Figure 16. Filtering in Wireshark to find email header lines for unencrypted SMTP traffic.*

After filtering for SMTP traffic as show in Figure 16, you can follow TCP stream for any of the displayed frames, and you'll find one of the  emails sent from the spambot.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure17.png)*Figure 17. TCP stream showing unencrypted SMTP traffic from a spambot-infected host.*

**Saving Your Filters**

Some filter expressions are very tedious to type out each time, but  you can save them as filter buttons. On the right side of the Wireshark  filter bar is a plus sign to add a filter button.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure18.png)*Figure 18. Saving a filter expression as a filter expression button in Wireshark.*

Click on that plus sign to save your expression as a filter button. You have the following fields:

- Label
- Filter
- Comment

The comment is optional, and the filter defaults to whatever is  currently typed in the Wireshark filter bar. Once you have typed your  label, then click the OK button as shown in Figure 19.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure19.png)*Figure 19. After typing a filter label, click the OK button.*

In the above image, I typed "basic" for the filter ***(http.request or ssl.handshake.type == 1) and !(udp.port eq 1900)\*** to save as my basic filter. Figure 20 show that filter button labeled "basic" to the right of the plus sign.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure20.png)*Figure 20. My "basic" filter button at the far right of the filter bar.*

For my normal filter setup in Wireshark, I create the following filter buttons:

- basic ***(http.request or ssl.handshake.type == 1) and !(udp.port eq 1900)\***
- basic+ ***(http.request or ssl.handshake.type == 1 or tcp.flags eq 0x0002) and !(udp.port eq 1900)\***
- basic+DNS ***(http.request or ssl.handshake.type == 1 or tcp.flags eq 0x0002 or dns) and !(udp.port eq 1900)\***

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/01/Figure21.png)

*Figure 21. Filter buttons I routinely use on Wireshark.*

**Summary**

This tutorial covered the following areas:

- Indicators of infection traffic
- The Wireshark display filter
- Filters for web-based infection traffic
- Filters for other types of infection traffic
- Saving your filters

### Identifying Hosts and Users

When a host is infected or otherwise compromised, security  professionals need to quickly review packet captures (pcaps) of  suspicious network traffic to identify affected hosts and users.

This tutorial offers tips on how to gather that pcap data using  Wireshark, the widely used network protocol analysis tool. It assumes  you understand network traffic fundamentals and will use [these](https://www.malware-traffic-analysis.net/training/host-and-user-ID.html) pcaps of [IPv4](https://en.wikipedia.org/wiki/IPv4) traffic to cover retrieval of four types of data:

- Host information from DHCP traffic
- Host information from NetBIOS Name Service (NBNS) traffic
- Device models and operating systems from HTTP traffic
- Windows user account from Kerberos traffic

**Host Information from DHCP Traffic**

Any host generating traffic within your network should have three identifiers: a [MAC address](https://en.wikipedia.org/wiki/MAC_address), an [IP address](https://en.wikipedia.org/wiki/IP_address), and a [hostname](https://en.wikipedia.org/wiki/Hostname).

In most cases, alerts for suspicious activity are based on IP  addresses. If you have access to full packet capture of your network  traffic, a pcap retrieved on an internal IP address should reveal an  associated MAC address and hostname.

How do we find such host information using Wireshark? We filter on two types of activity: [DHCP](https://wiki.wireshark.org/DHCP) or [NBNS](https://wiki.wireshark.org/NetBIOS/NBNS). DHCP traffic can help identify hosts for almost any type of computer  connected to your network. NBNS traffic is generated primarily by  computers running Microsoft Windows or Apple hosts running MacOS.

The first pcap for this tutorial, ***host-and-user-ID-pcap-01.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/host-and-user-ID.html). This pcap is for an internal IP address at 172.16.1[.]207. Open the pcap in Wireshark and filter on ***bootp\*** as shown in Figure 1. This filter should reveal the DHCP traffic.

**Note**: With Wireshark 3.0, you must use the search term **dhcp** instead of **bootp**.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-1-Filtering-on-DHCP-traffic-in-Wireshark.png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-1-Filtering-on-DHCP-traffic-in-Wireshark.png)

*Figure 1: Filtering on DHCP traffic in Wireshark*

Select one of the frames that shows ***DHCP Request\*** in the info column. Go to the frame details section and expand the line for ***Bootstrap Protocol (Request)\*** as shown in Figure 2. Expand the lines for ***Client Identifier\*** and ***Host Name\*** as indicated in Figure 3. Client Identifier details should reveal the  MAC address assigned to 172.16.1[.]207, and Host Name details should  reveal a hostname.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-2-Expanding-Bootstrap-Protocol-line-from-a-DHCP-request..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-2-Expanding-Bootstrap-Protocol-line-from-a-DHCP-request..png)

*Figure 2: Expanding Bootstrap Protocol line from a DHCP request*

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-3-Finding-the-MAC-address-and-hostname-in-a-DHCP-request..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-3-Finding-the-MAC-address-and-hostname-in-a-DHCP-request..png)

*Figure 3: Finding the MAC address and hostname in a DHCP request*

In this case, the hostname for 172.16.1[.]207 is ***Rogers-iPad\*** and the MAC address is ***7c:6d:62:d2:e3:4f\***. This MAC address is assigned to Apple. Based on the hostname, this  device is likely an iPad, but we cannot confirm solely on the hostname.

We can easily correlate the MAC address and IP address for any frame with 172.16.1[.]207 as shown in Figure 4.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-4-Correlating-the-MAC-address-with-the-IP-address-from-any-frame..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-4-Correlating-the-MAC-address-with-the-IP-address-from-any-frame..png)

*Figure 4: Correlating the MAC address with the IP address from any frame*

**Host Information from NBNS Traffic**

Depending on how frequently a DHCP lease is renewed, you might not  have DHCP traffic in your pcap. Fortunately, we can use NBNS traffic to  identify hostnames for computers running Microsoft Windows or Apple  hosts running MacOS.

The second pcap for this tutorial, ***host-and-user-ID-pcap-02.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/host-and-user-ID.html). This pcap is from a Windows host using an internal IP address at 10.2.4[.]101. Open the pcap in Wireshark and filter on ***nbns\***. This should reveal the NBNS traffic. Select the first frame, and you  can quickly correlate the IP address with a MAC address and hostname as  shown in Figure 5.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-5-Correlating-hostname-with-IP-and-MAC-address-using-NBNS-traffic..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-5-Correlating-hostname-with-IP-and-MAC-address-using-NBNS-traffic..png)

*Figure 5: Correlating hostname with IP and MAC address using NBNS traffic*

The frame details section also shows the hostname assigned to an IP address as shown in Figure 6.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-6-Frame-details-for-NBNS-traffic-showing-the-hostname-assigned-to-an-IP-address..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-6-Frame-details-for-NBNS-traffic-showing-the-hostname-assigned-to-an-IP-address..png)

*Figure 6: Frame details for NBNS traffic showing the hostname assigned to an IP address*

**Device Models and Operating Systems from HTTP Traffic**

User-agent strings from headers in HTTP traffic can reveal the  operating system. If the HTTP traffic is from an Android device, you  might also determine the manufacturer and model of the device.

The third pcap for this tutorial, ***host-and-user-ID-pcap-03.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/host-and-user-ID.html). This pcap is from a Windows host using an internal IP address at 192.168.1[.]97. Open the pcap in Wireshark and filter on ***http.request and !(ssdp)\***. Select the second frame, which is the first HTTP request to ***www.ucla[.]edu\***, and follow the TCP stream as shown in Figure 7.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-7-Following-the-TCP-stream-for-an-HTTP-request-in-the-third-pcap..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-7-Following-the-TCP-stream-for-an-HTTP-request-in-the-third-pcap..png)

*Figure 7: Following the TCP stream for an HTTP request in the third pcap*

This TCP stream has HTTP request headers as shown in Figure 8. The  User-Agent line represents Google Chrome web browser version  72.0.3626[.]81 running on Microsoft's Windows 7 x64 operating system.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-8-The-User-Agent-line-for-a-Windows-7-x64-host-using-Google-Chrome..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-8-The-User-Agent-line-for-a-Windows-7-x64-host-using-Google-Chrome..png)

*Figure 8: The User-Agent line for a Windows 7 x64 host using Google Chrome*

*Note the following string in the User-Agent line from Figure 8:*

***(Windows NT 6.1; Win64; x64)\***

***Windows NT 6.1\*** represents Windows 7. For  User-Agent lines, Windows NT strings represent the following versions of Microsoft Windows as shown below:

- Windows NT 5.1: ***Windows XP\***
- Windows NT 6.0: ***Windows Vista\***
- Windows NT 6.1: ***Windows 7\***
- Windows NT 6.2: ***Windows 8\***
- Windows NT 6.3: ***Windows 8.1\***
- Windows NT 10.0: ***Windows 10\***

With HTTP-based web browsing traffic from a Windows host, you can  determine the operating system and browser. The same type of traffic  from Android devices can reveal the brand name and model of the device.

The fourth pcap for this tutorial, ***host-and-user-ID-pcap-04.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/host-and-user-ID.html). This pcap is from an Android host using an internal IP address at 172.16.4.119. Open the pcap in Wireshark and filter on ***http.request\***. Select the second frame, which is the HTTP request to ***www.google[.]com\*** for ***/blank.html\***. Follow the TCP stream as shown in Figure 9.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-9-Following-the-TCP-stream-for-an-HTTP-request-in-the-fourth-pcap..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-9-Following-the-TCP-stream-for-an-HTTP-request-in-the-fourth-pcap..png)

*Figure 9: Following the TCP stream for an HTTP request in the fourth pcap*

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-10-The-User-Agent-line-for-an-Android-host-using-Google-Chrome..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-10-The-User-Agent-line-for-an-Android-host-using-Google-Chrome..png)

*Figure 10: The User-Agent line for an Android host using Google Chrome*

The User-Agent line in Figure 10 shows ***Android 7.1.2\*** which is an older version of the Android operating system released in April 2017. ***LM-X210APM\*** represents a model number for this Android device. A [quick Google search](https://www.google.com/search?q=LM-X210APM) reveals this model is an [LG Phoenix 4 Android smartphone](https://www.lg.com/us/support-mobile/lg-LMX210APM).

The User-Agent line for HTTP traffic from an iPhone or other Apple  mobile device will give you the operating system, and it will give you  the type of device. However, it will not give you a model. We can only  determine if the Apple device is an iPhone, iPad, or iPod. We cannot  determine the model.

The fifth pcap for this tutorial, ***host-and-user-ID-pcap-05.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/host-and-user-ID.html). This pcap is from an iPhone host using an internal IP address at 10.0.0[.]114. Open the pcap in Wireshark and filter on ***http.request\***. Select the frame for the first HTTP request to ***web.mta[.]info\*** and follow the TCP stream as shown in Figure 11.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-11-Following-the-TCP-stream-for-an-HTTP-request-in-the-fifth-pcap..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-11-Following-the-TCP-stream-for-an-HTTP-request-in-the-fifth-pcap..png)

*Figure 11: Following the TCP stream for an HTTP request in the fifth pcap*

In Figure 12, the User-Agent line shows ***(iPhone; CPU iPhone OS 12_1_3 like Mac OS X)\***. This indicates the Apple device is an iPhone, and it is running iOS 12.1.3.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-12-The-User-Agent-line-for-an-iPhone-using-Safari..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-12-The-User-Agent-line-for-an-iPhone-using-Safari..png)

*Figure 12: The User-Agent line for an iPhone using Safari*

A final note about HTTP traffic and User-Agent strings: not all HTTP  activity is web browsing traffic. Some HTTP requests will not reveal a  browser or operating system. When you search through traffic to identify a host, you might have to try several different HTTP requests before  finding web browser traffic.

Since more websites are using HTTPS, this method of host  identification can be difficult. HTTP headers and content are not  visible in HTTPS traffic. However, for those lucky enough to find HTTP  web-browsing traffic during their investigation, this method can provide more information about a host.

**Windows User Account from Kerberos Traffic**

For Windows hosts in an Active Directory (AD) environment, we can find user account names in from Kerberos traffic.

The sixth pcap for this tutorial, ***host-and-user-ID-pcap-06.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/host-and-user-ID.html). This pcap is from a Windows host in the following AD environment:

- Domain: 

  *happycraft[.]org*

  - Network segment: ***172.16.8.0/24\*** (172.16.8[.]0 - 172.16.8[.]255)

- Domain controller IP: ***172.16.8[.]8\***

- Domain controller hostname: ***Happycraft-DC\***

- Segment gateway: ***172.16.8[.]1\***

- Broadcast address: ***172.16.8[.]255\***

- Windows client: ***172.16.8[.]201\***

Open the pcap in Wireshark and filter on ***kerberos.CNameString\***. Select the first frame. Go to the frame details section and expand lines as shown in Figure 13. Select the line with ***CNameString: johnson-pc$\*** and apply it as a column.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-13-Finding-the-CNameString-value-and-applying-it-as-a-column..png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-13-Finding-the-CNameString-value-and-applying-it-as-a-column..png)

*Figure 13: Finding the CNameString value and applying it as a column*

This should create a new column titled ***CNameString\***. Scroll down to the last frames in the column display. You should find a user account name for ***theresa.johnson\*** in traffic between the domain controller at 172.16.8[.]8 and the Windows client at 172.16.8[.]201 as shown in Figure 14.

[![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-14-Finding-the-W.png)](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/03/Figure-14-Finding-the-W.png)

*Figure 14: Finding the Windows user account name*

CNameString values for hostnames always end with a ***$\*** (dollar sign), while user account names do not. To filter on user  account names, use the following Wireshark expression to eliminate  CNameString results with a dollar sign:

***kerberos.CNameString and !(kerberos.CNameString contains $)\***

**Summary**

Proper identification of hosts and users from network traffic is  essential when reporting malicious activity in your network. Using the  methods from this tutorial, we can better utilize Wireshark to help us  identify affected hosts and users.

### Exporting Objects from a Pcap

When reviewing packet captures (pcaps) of suspicious activity,  security professionals may need to export objects from the pcaps for a  closer examination.

This tutorial offers tips on how to export different types of objects from a pcap. The instructions assume you understand network traffic  fundamentals. We will use [these](https://www.malware-traffic-analysis.net/training/exporting-objects.html) pcaps of network traffic to practice extracting objects using  Wireshark. The instructions also assume you have customized your  Wireshark column display as previously demonstrated in [this](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/) tutorial.

Warning: Most of these pcaps contain Windows malware, and this  tutorial involves examining these malicious files. Since these files are Windows malware, I recommend doing this tutorial in a non-Windows  environment, like a MacBook or Linux host. You could also use a virtual  machine (VM) running Linux.

This tutorial covers the following areas:

- Exporting objects from HTTP traffic
- Exporting objects from SMB traffic
- Exporting emails from SMTP traffic
- Exporting files from FTP traffic

**Exporting Objects from HTTP Traffic**

The first pcap for this tutorial, ***extracting-objects-from-pcap-example-01.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/exporting-objects.html). Open the pcap in Wireshark and filter on ***http.request\*** as shown in Figure 1.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image.png)*Figure 1. Filtering on the tutorial's first pcap in Wireshark.*

After filtering on ***http.request\***, find the two GET requests to ***smart-fax[.]com\***. The first request ends with ***.doc\***, indicating the first request returned a Microsoft Word document. The second request ends with ***.exe\***, indicating the second request returned a Windows executable file. The HTTP GET requests are listed below.

- ***smart-fax[.]com\*** - GET /Documents/Invoice&MSO-Request.doc
- ***smart-fax[.]com\*** - GET /knr.exe

We can export these objects from the HTTP object list by using the menu path: ***File --> Export Objects --> HTTP...\*** Figure 2 show this menu path in Wireshark.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-1.png)*Figure 2. Exporting HTTP objects in Wireshark.*

This menu path results in an Export HTTP object list window as shown in Figure 3. Select the first line with ***smart-fax[.]com\*** as the hostname and save it as shown in Figure 3. Select the second line with ***smart-fax[.]com\*** as the hostname and save it as shown in Figure 4.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-2.png)*Figure 3. Saving the suspected Word document from the HTTP object list.*

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-3.png)*Figure 4. Saving the suspected Windows executable file from the HTTP object list.*

Of note, the Content Type from the HTTP object list shows how the  server identified the file in its HTTP response headers. In some cases,  Windows executables are intentionally labeled as a different type of  file in an effort to avoid detection. Fortunately, the first pcap in  this tutorial is a very straight-forward example.

Still, we should confirm these files are what we think they are. In a MacBook or Linux environment, you can use a terminal window or command  line interface (CLI) for the following commands:

- **file** *[filename]*
- **shasum -a 256** *[filename]*

The ***file\*** command returns the type of file. The ***shasum\*** command will return the file hash, in this case the SHA256 file hash.  Figure 5 shows using these commands in a CLI on a Debian-based Linux  host.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-4.png)*Figure 5. Determining the file type and hash of our two objects exported from the pcap.*

The commands and their results from Figure 5 are listed below:

$ file Invoice\&MSO-Request.doc

Invoice&MSO-Request.doc: Composite Document File V2 Document, Little Endian, Os: Windows, Version 6.3, Code page: 1252, Template: Normal.dotm, Last Saved By:  Administrator, Revision Number: 2, Name of Creating Application:  Microsoft Office Word, Create Time/Date: Thu Jun 27 19:24:00 2019, Last  Saved Time/Date: Thu Jun 27 19:24:00 2019, Number of Pages: 1, Number of Words: 0, Number of Characters: 1, Security: 0

$ file knr.exe

knr.exe: PE32 executable (GUI) Intel 80386, for MS Windows

$ shasum -a 256 Invoice\&MSO-Request.doc

f808229aa516ba134889f81cd699b8d246d46d796b55e13bee87435889a054fb Invoice&MSO-Request.doc

$ shasum -a 256 knr.exe

749e161661290e8a2d190b1a66469744127bc25bf46e5d0c6f2e835f4b92db18 knr.exe

The information above confirms our suspected Word document is in fact a Microsoft Word document. It also confirms the suspected Windows  executable file is indeed a Windows executable. We can check the SHA256  hashes against VirusTotal to see if these files are detected as malware. We could also do a Google search on the SHA256 hashes to possibly find  additional information.

In addition to Windows executable or other malware files, we can also extract web pages. Our second pcap for this tutorial, ***extracting-objects-from-pcap-example-02.pcap\*** (available [here](https://www.malware-traffic-analysis.net/training/exporting-objects.html)) contains traffic of someone entering login credentials on a fake PayPal login page.

When reviewing network traffic from a phishing site, we might want to see what the phishing web page looks like. We can extract the initial  HTML page using the Export HTTP object menu as shown in Figure 6. Then  we can view it through a web browser in an isolated environment as shown in Figure 7.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-5.png)*Figure 6. Exporting a fake PayPal login page from our second pcap.*

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-6.png)*Figure 7. The exported fake PayPal login page viewed in a web browser.*

**Exporting Objects from SMB Traffic**

Some malware uses Microsoft's Server Message Block (SMB) protocol to  spread across an Active Directory (AD)-based network. A banking Trojan  known as Trickbot added a worm module [as early as July 2017](https://securityintelligence.com/news/trickbot-learns-from-wannacry-and-petya-by-adding-self-spreading-worm-module/) that uses an exploit based on [EternalBlue](https://www.wired.co.uk/article/what-is-eternal-blue-exploit-vulnerability-patch) to spread across a network over SMB. We continue to find indications of this Trickbot worm module today.

Our next pcap represents a Trickbot infection that used SMB to spread from an infected client at 10.6.26.110 to its domain controller at  10.6.26.6. The pcap, ***extracting-objects-from-pcap-example-03.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/exporting-objects.html). Open the pcap in Wireshark. Use the menu path ***File --> Export Objects --> SMB...\*** as shown in Figure 8.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-7.png)*Figure 8. Getting to the Export SMB objects list.*

This brings up an Export SMB object list, listing SMB objects you can export from the pcap as shown below in Figure 9.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-8.png)*Figure 9. The export SMB object list.*

Notice the two entries near the middle of the list with  \\10.6.26.6\C$ as the Hostname. A closer examination of their respective Filename fields indicates these are two Windows executable files. See  Table 1 below for details.

| **Packet number** | **Hostname**   | **Content Type**                | **Size** | **Filename**                                                 |
| ----------------- | -------------- | ------------------------------- | -------- | ------------------------------------------------------------ |
| 7058              | \\10.6.26.6\C$ | FILE (712704/712704) W [100.0%] | 712 kB   | \WINDOWS\d0p2nc6ka3f_fixhohlycj4ovqfcy_smchzo_ub83urjpphrwahjwhv_o5c0fvf6.exe |
| 7936              | \\10.6.26.6\C$ | FILE (115712/115712) W [100.0%] | 115 kB   | \WINDOWS\oiku9bu68cxqenfmcsos2aek6t07_guuisgxhllixv8dx2eemqddnhyh46l8n_di.exe |

*Table 1. Data from the Export SMB objects list on the two Windows executable files.*

In the Content Type column, we need [100.00%] to export a correct  copy of these files. Any number less than 100 percent indicates there  was some data loss in the network traffic, resulting in a corrupt or  incomplete copy of the file. These Trickbot-related files from the pcap  have SHA256 file hashes as shown in Table 2.

| **SHA256 hash**                                              | **File size** |
| ------------------------------------------------------------ | ------------- |
| 59896ae5f3edcb999243c7bfdc0b17eb7fe28f3a66259d797386ea470c010040 | 712 kB        |
| cf99990bee6c378cbf56239b3cc88276eec348d82740f84e9d5c343751f82560 | 115 kB        |

*Table 2. SHA256 file hashes for the Windows executable files.*

**Exporting Emails from SMTP Traffic**

Certain types of malware are designed to turn an infected Windows  host into a spambot. These spambots send hundreds of spam messages or  malicious emails every minute. In some cases, the messages are sent  using unencrypted SMTP, and we can export these messages from a pcap of  the infection traffic.

One such example is from our next pcap, ***extracting-objects-from-pcap-example-04.pcap\*** (available [here](https://www.malware-traffic-analysis.net/training/exporting-objects.html)). In this pcap, an infected Windows client sends [sextortion spam](https://www.eff.org/deeplinks/2018/07/sextortion-scam-what-do-if-you-get-latest-phishing-spam-demanding-bitcoin). Open the pcap in Wireshark, filter on ***smtp.data.fragment\***, and you should see 50 examples of subject lines as shown in Figure 10.  This happened in five seconds of network traffic from a single infected  Windows host.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-9.png)*Figure 10. Filtering for email senders and subject lines in Wireshark.*

You can export these messages using the menu path ***File --> Export Objects --> IMF...\*** as shown in Figure 11. IMF stands for [Internet Message Format](https://www.loc.gov/preservation/digital/formats/fdd/fdd000393.shtml), which is saved as a name with an [.eml](https://www.loc.gov/preservation/digital/formats/fdd/fdd000388.shtml) file extension.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-10.png)*Figure 11. Exporting emails from a pcap in Wireshark.*

The sextortion spam messages are all listed with an .eml file extension in the IMF object list as shown in Figure 12.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-11.png)*Figure 12. List of spam messages in the IMF object list.*

After they are exported, these .eml files can be reviewed with an  email client like Thunderbird, or they can be examined in a text editor  as shown in Figure 13.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-12.png)Figure 13. Using a text editor to view an .eml file exported from the pcap.*

**Exporting files from FTP Traffic**

Some malware families use FTP during malware infections. Our next  pcap has malware executables retrieved from an FTP server followed by  information from the infected Windows host sent back to the same FTP  server.

The next pcap is ***extracting-objects-from-pcap-example-05.pcap\*** and is available [here](https://www.malware-traffic-analysis.net/training/exporting-objects.html). Open the pcap in Wireshark. Filter on ***ftp.request.command\*** to review the FTP commands as shown in Figure 14. You should find a  username (USER) and password (PASS) followed by requests to retrieve  (RETR) five Windows executable files: ***q.exe\***, ***w.exe\***, ***e.exe\***, ***r.exe\***, and ***t.exe\***. This is followed by requests to store (STOR) html-based log files back to the same FTP server approximately every 18 seconds.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-13.png)*Figure 14. Filtering for FTP requests in Wireshark.*

Now that we have an idea of the files that were retrieved and sent,  we can review traffic from the FTP data channel using a filter for ***ftp-data\*** as shown in Figure 15.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-14.png)*Figure 15. Filtering on FTP data traffic in Wireshark.*

We cannot use the ***Export Objects\*** function  in Wireshark to export these objects. However, we can follow the TCP  stream from the data channels for each. Left-click on any of the lines  that end with (SIZE q.exe) to select one of the TCP segments. Then  right-click to bring up a menu and select the menu path for ***Follow --> TCP stream\*** as shown in Figure 16.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-15.png)*Figure 16. Following the TCP stream of an FTP data channel for* ***q.exe\****.*

This will bring up the TCP stream for ***q.exe\*** over the FTP data channel. Near the bottom of the window is a  button-style menu labeled "Show and save data as" which defaults to  ASCII as shown in Figure 17. Click on the menu and select "Raw" as shown in Figure 18.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-16.png)*Figure 17. The TCP stream window for* ***q.exe\****. Note the "Show and save data as" button-style menu.*

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-17.png)*Figure 18. Selecting "Raw" from the "Show and save data as" menu.*

The window should now show hexadecimal characters instead of ASCII as shown in Figure 19. Use the ***Save as...\*** button near the bottom of the window to save this as a raw binary, also shown in Figure 19.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-18.png)*Figure 19. Saving the data from a TCP stream as a raw binary.*

Save the file as ***q.exe\***. In a Linux or similar CLI environment, confirm this is a Windows executable file and get the SHA256 hash as shown below.

$ file q.exe

q.exe: PE32 executable (GUI) Intel 80386, for MS Windows

$ shasum -a 256 q.exe

ca34b0926cdc3242bbfad1c4a0b42cc2750d90db9a272d92cfb6cb7034d2a3bd q.exe

The SHA256 hash shows a high detection rate as malware [on VirusTotal](https://www.virustotal.com/gui/file/ca34b0926cdc3242bbfad1c4a0b42cc2750d90db9a272d92cfb6cb7034d2a3bd/detection). Follow the same process for the other .exe files in the pcap:

- Filter on ***ftp-data\***
- Follow the TCP stream for a TCP segment with the name of your file in the Info column
- Change "Show and save data as" to "Raw"
- Use the "Save as..." button to save the file
- Check to make sure your saved file is, in fact, a Windows executable file.

This should give you the following files as shown below in Table 3.

| **SHA256 hash**                                              | **File name** |
| ------------------------------------------------------------ | ------------- |
| 32e1b3732cd779af1bf7730d0ec8a7a87a084319f6a0870dc7362a15ddbd3199 | e.exe         |
| ca34b0926cdc3242bbfad1c4a0b42cc2750d90db9a272d92cfb6cb7034d2a3bd | q.exe         |
| 4ebd58007ee933a0a8348aee2922904a7110b7fb6a316b1c7fb2c6677e613884 | r.exe         |
| 10ce4b79180a2ddd924fdc95951d968191af2ee3b7dfc96dd6a5714dbeae613a | t.exe         |
| 08eb941447078ef2c6ad8d91bb2f52256c09657ecd3d5344023edccf7291e9fc | w.exe         |

*Table 3. Executable files from the FTP traffic.*

We have to search more precisely when exporting the HTML files sent  from the infected Windows host back to the FTP server. Why? Because the  same file name is used each time. Filter on ***ftp.request.command\***, and scroll to the end. We can see the same file name used to store  (STOR) stolen data to the FTP server as an HTML file as shown in Figure  20.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-19.png)*Figure 20. The same file name used for sending stolen info back to the FTP server.*

To see the associated files sent over the ftp data channel, use the filter ***ftp-data.command contains .html\*** as shown in Figure 21.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/07/word-image-20.png)*Figure 21. Filtering on files with* ***.html\*** *in the file name over the FTP data channel.*

In Figure 21, the destination port changes each time the file is  stored (STOR) to the FTP server. The first time has TCP port 52202. The  second time has TCP port 57791. The third time has TCP port 55045. The  fourth time has 57203. And the fifth time has 61099.

We use the same process as before. Instead of focusing on the file  names, focus on the TCP ports. Follow the TCP stream for any of the TCP  segments using port 52202. In the TCP stream window, change "Show and  save data as" to "Raw." Then save the file. Do the same for the HTML  file over TCP port 57791.

If you do this for all five HTML files, you'll find they are the same exact file. These text-based HTML files contain data about the infected Windows host, including any passwords found by the malware.

**Summary**

Using the methods outlined in this tutorial, we can extract various  objects from a pcap using Wireshark. This can be extremely helpful when  you need to examine items from network traffic.

### Examining Trickbot Infections

When a host is infected or otherwise compromised, security  professionals with access to packet captures (pcaps) of the network  traffic need to understand the activity and identify the type of  infection.

This tutorial offers tips on how to identify Trickbot, an information stealer and banking malware that has been [infecting victims since 2016](https://www.forbes.com/sites/leemathews/2019/07/14/stealthy-trickbot-malware-has-compromised-250-million-email-accounts-and-is-still-going-strong/#6f92d6d94884). Trickbot is distributed through malicious spam (malspam), and it is also distributed by other malware such as [Emotet](https://www.malware-traffic-analysis.net/2019/10/02/index.html), [IcedID](https://www.malware-traffic-analysis.net/2019/10/31/index.html), or [Ursnif](https://www.malware-traffic-analysis.net/2019/10/09/index.html).

Trickbot has distinct traffic patterns. This tutorial reviews pcaps  of Trickbot infections caused by two different methods: a Trickbot  infection from malspam and Trickbot when it is distributed through other malware.

Note: Today’s tutorial requires Wireshark with a column display customized according to [this previous tutorial](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/). You should already have implemented Wireshark display filters as described [here](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/).

#### **Trickbot from malspam**

Trickbot is often distributed through malspam. Emails from these  campaigns contain links to download malicious files disguised as  invoices or documents. These files may be Windows executable files for  Trickbot, or they may be some sort of downloader for the Trickbot  executable. In some cases, links from these emails return a zip archive  that contains a Trickbot executable or downloader.

Figure 1 shows an example from September 2019. In this example, the  email contained a link that returned a zip archive. The zip archive  contained a Windows shortcut file that downloaded a Trickbot executable. A pcap for the associated Trickbot infection is available [here](https://www.malware-traffic-analysis.net/2019/09/25/index.html).

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-61-1024x554.png)
 *Figure 1: Flowchart from a Trickbot infection from malspam in September 2019.*

Download the pcap [from this page](https://www.malware-traffic-analysis.net/2019/09/25/index.html). The pcap is contained in a password-protected zip archive named ***2019-09-25-Trickbot-gtag-ono19-infection-traffic.pcap.zip\***. Extract the pcap from the zip archive using the password ***infected\*** and open it in Wireshark. Use your ***basic\*** filter to review the web-based infection traffic as shown in Figure 2.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-63-1024x570.png)Figure 2: Pcap of the Trickbot infection viewed in Wireshark.*

Review the traffic, and you will find the following activity common in recent Trickbot infections:

- An IP address check by the infected Windows host
- HTTPS/SSL/TLS traffic over TCP ports 447 and 449
- HTTP traffic over TCP port 8082
- HTTP requests ending in ***.png\*** that return Windows executable files

Unique to this Trickbot infection is an HTTP request to ***www.dchristjan[.]com\*** that returned a zip archive and an HTTP request to ***144.91.69[.]195\*** that returned a Windows executable file. Follow the HTTP stream for the request to ***www.dchristjan[.]com\*** as shown in Figure 3 to review the traffic. In the HTTP stream, you  will find indicators that a zip archive was returned as shown in Figure  4.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-65-1024x580.png)*Figure 3: Following the HTTP stream for the request to www.dchristjan[.]com.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-67-1024x796.png)Figure 4: Indicators the HTTP request returned a zip archive.*

In Figure 4, you can also see the name of the file contained in the zip archive, ***InvoiceAndStatement.lnk\***. You can export the zip archive from the traffic using Wireshark as shown in Figure 5 and Figure 6 using the following path:

   ***File → Export Objects → HTTP…\***

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-69-1024x573.png)Figure 5: Exporting HTTP objects from the pcap.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-70-1024x477.png)
 Figure 6: Exporting the zip archive from the pcap.*

In a BSD, Linux, or Mac environment, you can easily confirm the  extracted file is a zip archive, get the SHA256 hash of the file, and  extract the contents of the archive in a command line environment. In  this case, the content is a Windows shortcut file, which you can also  confirm and get the SHA256 hash as shown in Figure 7.

The command to identify the file type is **file** *[filename]*, while the command to find the SHA256 hash of the file is **shasum -a 256** *[filename]*.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-72-1024x520.png)Figure 7: Checking the extracted zip archive and its contents.*

An HTTP request to ***144.91.69[.]195\*** returned a Windows executable file. This is the initial Windows executable for  Trickbot. You can follow the HTTP stream for this HTTP request and find  indicators this is an executable file as shown in Figure 8 and Figure 9. You can extract the executable file from the pcap as shown in Figure  10.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-73-1024x706.png)Figure 8: Following the HTTP stream for the HTTP request to 144.91.69[.]195.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-74-1024x755.png)Figure 9: Indicators the returned file is a Windows executable or DLL file.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-75-1024x546.png)Figure 10: Exporting the Windows executable from the pcap.*

Post infection traffic initially consists of HTTPS/SSL/TLS traffic  over TCP port 443, 447, or 449 and an IP address check by the infected  Windows host. In this infection, shortly after the HTTP request for the  Trickbot executable, we can see several attempted TCP connections over  port 443 to different IP addresses before the successful TCP connection  to 187.58.56[.]26 over TCP port 449. If you use your ***basic+\*** filter, you can see these attempted connections as shown in Figure 11 and Figure 12.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-76-1024x704.png)Figure 11: Attempted TCP connections over port 443 by the infected Windows host.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-77-1024x705.png)Figure 12: Scrolling down to see more TCP connections over port 443 before a  successful connection to 187.58.56[.]26 over TCP port 449.*

The HTTPS/SSL/TLS traffic to various IP addresses over TCP port 447  and TCP port 449 has unusual certificate data. We can review the  certificate issuer by filtering on ***ssl.handshake.type == 11\*** when using Wireshark 2.x or ***tls.handshake.type == 11\*** when using Wireshark 3.x. Then go to the frame details section and  expand the information, finding your way to the certificate issuer data  as seen in Figure 13 and Figure 14.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-78-1024x706.png)*Figure 13: Filtering for the certificate data in the HTTPS/SSL/TLS traffic,  then expanding lines the frame details for the first result under TCP  port 449.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-79-1024x704.png)Figure 14: Drilling down to the certificate issuer data on the first result over TCP port 449.*

In Figure 14, we see the following certificate issuer data used in HTTPS/SSL/TLS traffic to 187.58.56[.]26 over TCP port 449:

- id-at-countryName=***AU\***
- id-at-stateOrProvinceName=***Some-State\***
- id-at-organizationName=***Internet Widgits Pty Ltd\***

The state or province name (Some-State) and the organization name  (Internet Widgits Pty Ltd) are not used for legitimate HTTPS/SSL/TLS  traffic. This is an indicator of malicious traffic, and this type of  unusual certificate issuer data is not limited to Trickbot. What does a  normal certificate issuer look like in legitimate HTTPS/SSL/TLS traffic? If we look at earlier traffic to Microsoft domains at 72.21.81.200 over TCP port 443, we find the following as seen in Figure 15.

- id-at-countryName=***US\***
- id-at-stateOrProvinceName=***Washington\***
- id-at-localityName=***Redmond\***
- id-at-organizationName=***Microsoft Corporation\***
- id-at-organizationUnitName=***Microsoft IT\***
- id-at-commonName=***Microsoft IT TLS CA 2\***

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-80-1024x586.png)*Figure 15: Certificate data from legitimate HTTPS traffic to a Microsoft domain.*

The Trickbot-infected Windows host will check its IP address using a  number of different IP address checking sites. These sites are ***not\*** malicious, and the traffic is not inherently malicious. However, this  type of IP address check is common with Trickbot and other families of  malware. Various legitimate IP address checking services used by  Trickbot include:

- ***api.ip[.]sb\***
- ***checkip.amazonaws[.]com\***
- ***icanhazip[.]com\***
- ***ident[.]me\***
- ***ip.anysrc[.]net\***
- ***ipecho[.]net\***
- ***ipinfo[.]io\***
- ***myexternalip[.]com\***
- ***wtfismyip[.]com\***

Again, an IP address check by itself is not malicious. However, this  type of activity combined with other network traffic can provide  indicators of an infection, like we see in this case.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-81-1024x585.png)*Figure 16: IP address check by the infected Windows host, right after  HTTPS/SSL/TLS traffic over TCP port 449. Not inherently malicious, but  this is part of a Trickbot infection.*

A Trickbot infection currently generates HTTP traffic over TCP port  8082 this traffic sends information from the infected host like system  information and passwords from the browser cache and email clients. This information is sent from the infected host to command and control  servers used by Trickbot.

To review this traffic, use the following Wireshark filter:

***http.request and tcp.port eq 8082\***

This reveals the following HTTP requests as seen in Figure 17:

- 170.238.117[.]187 port 8082 - ***170.238.117[.]187\*** - POST
   /ono19/BACHMANN-BTO-PC_W617601.AC3B679F4A22738281E6D7B0C5946
   E42/81/
- 170.238.117[.]187 port 8082 - ***170.238.117[.]187\*** - POST
   /ono19/BACHMANN-BTO-PC_W617601.AC3B679F4A22738281E6D7B0C5946
   E42/83/
- 170.238.117[.]187 port 8082 - ***170.238.117[.]187\*** - POST
   /ono19/BACHMANN-BTO-PC_W617601.AC3B679F4A22738281E6D7B0C5946
   E42/81/
- 170.238.117[.]187 port 8082 - ***170.238.117[.]187:8082\*** - POST
   /ono19/BACHMANN-BTO-PC_W617601.AC3B679F4A22738281E6D7B0C5946
   E42/81/
- 170.238.117[.]187 port 8082 - ***170.238.117[.]187:8082\*** - POST
   /ono19/BACHMANN-BTO-PC_W617601.AC3B679F4A22738281E6D7B0C5946
   E42/90
- 170.238.117[.]187 port 8082 - ***170.238.117[.]187:8082\*** - POST
   /ono19/BACHMANN-BTO-PC_W617601.AC3B679F4A22738281E6D7B0C5946
   E42/90

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-82-1024x362.png)Figure 17: HTTP traffic over TCP port 8082 caused by Trickbot.*

HTTP POST requests ending in 81 send cached password data from web  browsers, email clients, and other applications. HTTP POST requests  ending in 83 send form data submitted by applications like web browsers. We can find system information sent through HTTP POST requests ending  in 90. Follow the TCP or HTTP streams for any of these HTTP POST  requests to review data stolen by this infection.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-83-1024x804.png)Figure 18: Login credentials stolen by Trickbot from the Chrome web browser.  This data was sent by the Trickbot-infected host using HTTP traffic over TCP port 8082.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-84-1024x806.png)Figure 19: System data sent by a Trickbot-infected host using HTTP traffic  over TCP port 8082. It starts with a list of running processes.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-85-1024x802.png)Figure 20: More system data sent by a Trickbot-infected host using HTTP  traffic over TCP port 8082. This is later from the same HTTP stream that started in Figure 19.*

Trickbot sends more Windows executable files over HTTP GET requests ending in ***.png\***. These follow-up Trickbot executables are used to infect a vulnerable  domain controller (DC) when the infected Windows host is a client in an  Active Directory environment.

You can find these URLs in the pcap by using the following Wireshark filter:

   ***http.request and ip contains .png\***

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-86-1024x304.png)Figure 21: Filtering to find follow-up Trickbot EXE files sent using URLs ending with .png.*

Follow the TCP or HTTP stream in each of the three requests as shown  in Figure 21. You should see indicators of windows executable files  similar to what we saw in Figure 9. However, in this case, the HTTP  response headers identify the returned file as image/png even though it  clearly is a Windows executable or DLL file.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-87-1024x747.png)Figure 22: Windows executable sent through URL ending in .png.*

You can export these files from Wireshark, confirm they are Windows  executable files, and get the SHA256 file hashes as we covered earlier  in this tutorial.

#### Trickbot Distributed Through Other Malware

Trickbot is frequently distributed  through other malware. Trickbot is commonly seen as follow-up malware to Emotet infections, but we have also seen it as follow-up malware from  IcedID and Ursnif infections

Since Emotet frequently distributes Trickbot, lets review an Emotet with Trickbot infection in September 2019 documented [here](https://www.malware-traffic-analysis.net/2019/09/25/index2.html). We already covered Emotet with Trickbot infections last year in [this Palo Alto Networks blog post](https://unit42.paloaltonetworks.com/unit42-malware-team-malspam-pushing-emotet-trickbot/), so this tutorial will focus on the Trickbot activity.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-88-1024x382.png)
 *Figure 23: Simplified flow chart for Emotet with Trickbot activity*.

Download the pcap [from this page](https://www.malware-traffic-analysis.net/2019/09/25/index.html). The pcap is contained in a password-protected zip archive named ***2019-09-25-Emotet-infection-with-Trickbot-in-AD-environment.pcap.zip\***. Extract the pcap from the zip archive using the password ***infected\*** and open it in Wireshark. Use your ***basic\*** filter to review the web-based infection traffic as shown in Figure 24.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-89-1024x588.png)*Figure 24: Filtering on web traffic in an Emotet+Trickbot infection.*

Experienced analysts can usually identify the Emotet-generated  traffic and the Trickbot-generated traffic. Post-infection Emotet  activity consists HTTP traffic with encoded data returned by the server. This is distinctly different than post-infection Trickbot activity  which generally relies on HTTPS/SSL/TLS traffic for command and control  communications. Figure 25 points out the different infection traffic  between Emotet and Trickbot for this specific infection.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-90-1024x586.png)*Figure 25: The differences in Emotet and Trickbot traffic.*

This infection happened in an Active Directory environment with  10.9.25.102 as the infected Windows client and 10.9.25.9 as the DC.  Later in the traffic, we see the DC exhibit signs of Trickbot infection  as shown in Figure 26.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-91-1024x535.png)*Figure 26: Trickbot activity on the DC.*

How did the infection move from client to DC? Trickbot uses a version of the [EternalBlue](https://www.wired.com/story/eternalblue-leaked-nsa-spy-tool-hacked-world/) exploit to move laterally using Microsoft’s SMB protocol. In this case, the infected Windows client sent information several times over TCP  port 445 to the DC at 10.9.25.9, which then retrieved a Trickbot  executable from ***185.98.87[.]185/wredneg2.png\***. Use the ***basic+\*** filter to see the SYN segments for the traffic between the client at  10.9.25.102 and the DC at 10.9.25.9 right before the DC calls out to ***185.98.87[.]185\*** as shown in Figure 27

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-92-1024x703.png)*Figure 27: Finding traffic from the client at 10.9.25.102) to the DC at  10.9.25.9 (shown in grey) before the DC retrieved a Trickbot EXE from  196.98.87[.]185/wredneg2.png.*

Follow one of the TCP streams, for example the line with a source as  10.9.25.102 over TCP port 49321 and destination as 10.9.35.9 over TCP  port 445. This is highly unusual traffic for a client to send to a DC,  so it is likely related to the EternalBlue exploit. See Figure 28 for an example of this traffic

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/11/word-image-93-1024x725.png)Figure 28: Example of the unusual traffic from a client to DC over TCP port  445, possibly related to an EternalBlue-based exploit.*

Other than this unusual SMB traffic and the DC getting infected, any  Trickbot-specific activity in this pcap is remarkably similar to our  previous example.

### Examining Ursnif Infections

[Ursnif](https://attack.mitre.org/software/S0386/) is  banking malware sometimes referred to as Gozi or IFSB. The Ursnif family of malware has been active for years, and current samples generate  distinct traffic patterns.

This tutorial reviews packet captures (pcaps) of infection Ursnif traffic using [Wireshark](https://www.wireshark.org). Understanding these traffic patterns can be critical for security  professionals when detecting and investigating Ursnif infections.

This tutorial covers the following:

- Ursnif distribution methods
- Categories of Ursnif traffic
- Five examples of pcaps from Ursnif infections

Note: This tutorial assumes you have a basic knowledge of Wireshark, and it uses a customized column display shown in [this tutorial](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/). You should also have experience with Wireshark display filters as described in [this additional tutorial](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/).

**Ursnif Distribution Methods**

Ursnif can be distributed through web-based infection chains and  malicious spam (malspam). In some cases, Ursnif is a follow-up infection caused by different malware families like [Hancitor](https://unit42.paloaltonetworks.com/unit42-compromised-servers-fraud-accounts-recent-hancitor-attacks/), as reported in [this recent example](https://isc.sans.edu/forums/diary/Hancitor+infection+with+Pony+Evil+Pony+Ursnif+and+Cobalt+Strike/25532/).

We frequently find examples of Ursnif from malspam-based distribution campaigns, such as the example in Figure 1.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-42.jpeg)*Figure 1. Flowchart from one of the more common Ursnif distribution campaigns.*

**Categories of Ursnif Traffic**

This tutorial covers two categories of Ursnif infection traffic:

- Ursnif without HTTPS post-infection traffic
- Ursnif with HTTPS post-infection traffic

Malware samples from either of these categories create the same type  of artifacts on an infected Windows host. For example, both types of  Ursnif remain persistent on a Windows host by updating the Windows  registry, such as the example shown in Figure 2.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-43.jpeg)*Figure 2. Example of Windows registry updates caused by samples of Ursnif, either with or without HTTPS post-infection traffic.*

**Example 1: Ursnif without HTTPS**

The first pcap for this tutorial, ***Ursnif-traffic-example-1.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/examining-ursnif.html). The chain of events behind this traffic was tweeted [here](https://twitter.com/malware_traffic/status/1203071348941246464). Example 1 has been stripped of all traffic not directly related to the Ursnif infection.

Open the pcap in Wireshark and filter on ***http.request\*** as shown in Figure 3.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-44.jpeg)*Figure 3. The pcap for example 1 filtered in Wireshark.*

In this example, the Ursnif-infected host generates post-infection traffic to 8.208.24[.]139 using various domain names ending with .at. This category of Ursnif causes the following traffic:

- HTTP GET requests caused by the initial Ursnif binary
- HTTP GET request for follow-up data, with the URL ending in .dat
- HTTP GET and POST requests after Ursnif is persistent in the Windows registry

The following HTTP data is used during the traffic in our first example:

- Domain for initial GET requests: w8.wensa[.]at
- Request for follow-up data: hxxp://api2.casys[.]at/jvassets/xI/t64.dat
- Domain for GET and POST requests after Ursnif is persistent: h1.wensa[.]at

Follow the TCP stream for the very first HTTP GET request at 20:13:09 UTC. The TCP stream window shows the full URL. Note how the GET request starts with /api1/ and is followed by a long string of alpha-numeric characters with  backslashes and underscores. Figure 4 highlights the GET request.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-45.jpeg)*Figure 4. Example of an HTTP GET request caused by our first Ursnif example.*

We can find the same pattern from Ursnif activity caused by a Hancitor infection on December 10,2019. The pcap is available [here](https://www.malware-traffic-analysis.net/2019/12/10/index.html). Mixed with the other malware activity, this December 10th example contains the following indicators for Ursnif:

- Domain for initial GET requests: foo.fulldin[.]at
- Request for follow-up data: hxxp://one.ahah100[.]at/jvassets/o1/s64.dat
- Domain for GET and POST requests after Ursnif is persistent: api.ahah100[.]at

Note how patterns from Ursnif traffic in the December 10th example  are similar to the patterns we find in example 1. These patterns are  commonly seen from Ursnif samples that do not use HTTPS traffic.

**Example 2: Ursnif with HTTPS**

The second pcap for this tutorial, ***Ursnif-traffic-example-2.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/examining-ursnif.html). Like our first pcap, this one has also been stripped of any traffic not related to the Ursnif infection.

Open the pcap in Wireshark and filter on ***http.request or ssl.handshake.type == 1\*** as shown in Figure 5. If you are using Wireshark 3.0 or newer, filter on ***http.request or tls.handshake.type == 1\*** for the correct results.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-46.jpeg)*Figure 5. The pcap for our second example filtered in Wireshark.*

This example has the following sequence of events:

- HTTP GET request that returns an initial Ursnif binary
- HTTP GET requests caused by the initial Ursnif binary
- HTTPS traffic after Ursnif is persistent in the Windows registry

Follow the TCP stream for the first HTTP GET request to ghinatronx[.]com. This TCP stream reveals a Windows executable or DLL file as shown in  Figure 6. We can export the Ursnif binary from the pcap as described in[ this previous tutorial](https://unit42.paloaltonetworks.com/using-wireshark-exporting-objects-from-a-pcap/).

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-47.jpeg)*Figure 6. The first HTTP GET request returning a binary for Ursnif.*

The next four HTTP requests to bjanicki[.]com were caused by the Ursnif binary. Follow the TCP stream for the first HTTP GET request to bjanicki[.]com at 18:46:21 UTC. This TCP stream shows the full URL. Note how the GET request starts with /images/ and is followed by a long string of alpha-numeric characters with backslashes and underscores before ending with .avi. This URL pattern is somewhat similar to Ursnif traffic from our first  pcap. Figure 7 highlights a GET request from our second pcap.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-48.jpeg)*Figure 7. Example of an HTTP GET request from our second Ursnif example.*

Unlike our first example, Ursnif in this second pcap generates HTTPS  traffic after it becomes persistent on an infected Windows host. Use  your ***basic\*** web filter as described in[ this previous tutorial](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/) for a quick review of the HTTPS traffic. Note the HTTPS traffic to prodrigo29lbkf20[.]com as shown in Figure 8.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-49.jpeg)*Figure 8. Filtering on web traffic in Wireshark, highlighting the HTTPS traffic generated by Ursnif.*

HTTPS traffic generated by this Ursnif variant reveals distinct  characteristics in certificates used to establish encrypted  communications. To get a closer look, filter on ***ssl.handshake.type == 11\*** (or ***tls.handshake.type == 11\*** in Wireshark 3.0 or newer). Select the first frame in the results and  go to the frame details window. There we can expand lines and work our  way to the certificate issuer data. Figure 9 shows how to begin.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-50.jpeg)*Figure 9. Finding our way to the certificate issuer data.*

As shown in Figure 9, we expand the line for ***Secure Sockets Layer\*** in the frame details window. For Wireshark 3.0, this line shows as ***Transport Layer Security\***. Then we expand the line labeled ***TLSv1.2 Record Layer: Handshake Protocol: Certificate\***. Then we expand the line labeled ***Handshake Protocol: Certificate\***.

We keep expanding, until we find our way to the certificate issuer data as shown in Figure 10.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-51.jpeg)*Figure 10. Certificate issuer data from HTTPS traffic caused by Ursnif.*

In Figure 10 shown under the ***Handshake Protocol: Certificate\*** line, we work our way down through the following items:

- Certificates (615 bytes)
- Certificate: 30820260308201c9a003020102020900c692c94106d77dfc...
- signedCertificate
- Issuer: rdnSequence (6)
- rdnSequence: 6 items (id-at-commonName=*,id-at-organizationalUnitN...

Individual items under the ***rdnSequence\*** line show properties of the certificate issuer. These reveal the following characteristics:

- countryName=**XX**
- stateOrProvinceName=**1**
- localityName=**1**
- organizationName=**1**
- organizationalUnitName=**1**
- commonName=*****

This issuer data is not valid, and these patterns are commonly seen  in Ursnif infections. But what does legitimate certificate data look  like? Figure 11 shows valid data from a certificate issued by DigiCert.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-52.jpeg)*Figure 11. Valid certificate issuer data.*

One last thing about Ursnif is the IP address check by an Ursnif-infected host. This happens over DNS using a resolver at opendns[.]com. Like other IP address identifiers, this is a legitimate service. However, these services are commonly used by malware.

To see this IP address check, filter on ***dns.qry.name contains opendns.com\*** and review the results as shown in Figure 12.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-53.jpeg)*Figure 12. IP address check by an Ursnif-infected Windows host.*

As shown in Figure 12, the Window host generated a dns query for resolver1.opendns[.]com followed by a DNS query to 208.67.222[.]222 for myip.opendns[.]com. The DNS query to myip.opendns[.]com returned the public IP address of the infected Windows host.

**Example 3: Ursnif with Follow-up Malware**

Our third pcap, ***Ursnif-traffic-example-3.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/examining-ursnif.html). This pcap also has unrelated activity stripped from the traffic, but it builds on our last example. Our third pcap includes what appears to be  decoy traffic, and it also includes an HTTP GET request for follow-up  malware. The sequence of events is:

- HTTP GET request that returns an initial Ursnif binary
- HTTP GET requests caused by the initial Ursnif binary, including decoy URLs
- HTTPS traffic after Ursnif is persistent in the Windows registry
- HTTP GET request for follow-up malware

Use your ***basic\*** web filter as described in[ this previous tutorial](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/) for a quick review of the web-based traffic as shown in Figure 13.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-54.jpeg)Figure 13. Filtering our third pcap for web traffic in Wireshark.*

In Figure 13, the initial HTTP request to sinicaleer[.]com returned a Windows executable for Ursnif. The remaining traffic visible Figure 13 was caused by the Ursnif executable until it became  persistent.

Three HTTP requests to google[.]com follow similar URL patterns as Ursnif traffic to an actual malicious domain of ghdy656262oe[.]com. These HTTP GET requests to google[.]com appear to be decoy traffic, because they do not assist the infection. HTTPS traffic over TCP port 443 to gmail[.]com and www.google[.]com also serves no direct purpose for the infection, and that activity  could also be classified as decoy traffic. Figure 14 shows an example of the decoy HTTP GET requests to google[.]com.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-55.jpeg)Figure 14. Decoy HTTP GET request by the Ursnif-infected host to a Google domain.*

Note the HTTP traffic to ghdy656262oe[.]com. The first two GET requests to ghdy656262oe[.]com return a ***404 Not Found\*** response as shown in Figure 15. The third HTTP GET request returns a ***200 OK\*** response, and the infection continues as shown in Figure 16.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-56.jpeg)*Figure 15. First two HTTP GET requests to malicious Ursnif domain return a 404 Not Found response.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-57.jpeg)Figure 16. Some false starts before the Ursnif infection continues.*

Since the first HTTP GET request to ghdy656262oe[.]com was not a 200 OK, the infected Windows host cycled through other  malicious domains to continue the infection. These two domains are tnzf3380au[.]top and xijamaalj[.]com. However, the DNS queries for these domains returned a “No such name” in response, so the infected Windows host went back to trying ghdy656262oe[.]com.

Use the following Wireshark filter to better see this sequence of events:

***((http.request or http.response) and ip.addr eq  194.1.236.191) or dns.qry.name contains tnzf3380au or dns.qry.name  contains xijamaalj\***

The results should appear similar to the column display in Figure 17.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-58.jpeg)*Figure 17. Filtering to show how the infected Windows host tries Ursnif-related domains before it hits a 200 OK in HTTP traffic.*

To review the rest of the infection, use your ***basic\*** web filter and scroll to the end of the results. Figure 18 shows the post-infection traffic after Ursnif becomes persistent.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-59.jpeg)*Figure 18. Post-infection traffic after Ursnif becomes persistent on the victim’s Windows host.*

In Figure 18, after five HTTP GET requests to ghdy656262oe[.]com, we find traffic generated by the infected Windows host after Ursnif becomes persistent. This includes HTTPS traffic to google[.]com and gmail[.]com.

Traffic to vnt69tnjacynthe[.]com should have the same type of certificate issuer data we witnessed in  our second pcap. But this traffic includes an HTTP GET request to carresqautomotive[.]com ending with .rar.

This URL ending in .rar returned follow-up malware. However, this  follow-up malware is encoded or otherwise encrypted when sent over the  network. The binary decoded on the infected Windows host, which is not  seen in the infection traffic. Follow the TCP stream for the HTTP GET  request to carresqautomotive[.]com, and you should see the same data as shown in Figure 19.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-60.jpeg)*Figure 19. Follow-up malware sent to an Ursnif-infected Windows host.*

This data is encrypted, so we cannot export a copy of the follow-up  malware from the pcap. Therefore, we must rely on other post-infection  traffic to determine what type of malware was sent to the  Ursnif-infected host.

We have seen various types of follow-up malware from Ursnif infections, including [Dridex](https://www.malware-traffic-analysis.net/2019/12/02/index.html), [IcedID](https://www.malware-traffic-analysis.net/2019/10/21/index.html), [Nymain](https://www.malware-traffic-analysis.net/2019/05/03/index.html), [Pushdo](https://www.malware-traffic-analysis.net/2019/07/29/index.html), and [Trickbot](https://www.malware-traffic-analysis.net/2019/09/04/index.html).

Our next example is an Ursnif infection with Dridex as the follow-up malware.

**Example 4: Ursnif Infection with Dridex**

Our fourth pcap, ***Ursnif-traffic-example-4.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/examining-ursnif.html). Unlike our first three examples, this pcap does not have unrelated activity stripped from the traffic.

Use your ***basic\*** web filter to get a better idea of the traffic. Your results should appear similar to Figure 20.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-61.jpeg)Figure 20. Traffic from our fourth pcap filtered in Wireshark.*

This pcap has the same sequence of events as our previous example,  but it adds post-infection activity from the follow-up malware:

- HTTP GET request that returns an initial Ursnif binary
- HTTP GET requests caused by the initial Ursnif binary, including decoy URLs
- HTTPS traffic after Ursnif is persistent in the Windows registry
- HTTP GET request for follow-up malware
- Post-infection activity from the follow-up malware

In this fourth example, the HTTP GET request for an initial Ursnif binary is to oklogallem[.]com. Ursnif causes HTTP GET requests to kh2714ldb[.]com before the infection becomes persistent.

Figure 21 shows activity after Ursnif is persistent, where Ursnif causes HTTPS traffic to s9971kbjjessie[.]com. We then see an HTTP GET request to startuptshirt[.]my for the follow-up malware. Finally we find post-infection traffic caused by the follow-up malware.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-62.jpeg)Figure 21. Activity from the infection after Ursnif is persistent.*

Our fourth example follows the same infection patterns as our third pcap, but now we also have HTTPS/SSL/TLS traffic to 94.140.114[.]6 and 5.61.34[.]51 without any associated domain name. This is Dridex post-infection traffic.

Certificate issuer data for Dridex is different than certificate  issuer data for Ursnif. Use the following filter to review the Dridex  certificate data in our fourth pcap:

***(ip.addr eq 94.140.114.6 or ip.addr eq 5.61.34.51) and ssl.handshake.type eq 11\***

Note: if you are using Wireshark 3.0 or newer, use ***tls.handshake.type\*** instead of ***ssl.handshake.type\***.

Select the first frame in the results, go to the frame details  window, and expand the certificate-related lines as shown by our second  example in Figures 9 and 10. Examining certificate issuer data from our  fourth pcap should look similar to Figures 22 and 23.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-63.jpeg)*Figure 22. Working our way to the certificate issuer data in the Dridex traffic.*

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-64.jpeg)Figure 23. Reaching the certificate issuer data from one of the Dridex IP addresses.*

Under the ***rdnSequence\*** line, we find properties of the certificate issuer. Certificate issuer characteristics for HTTPS/SSL/TLS traffic at 94.140.114[.]6 follows:

- countryName=**NP**
- localityName=**Kathmandu**
- organizationName=**Buvecoww Fftaites O.V.E.E.**
- organizationalUnitName=**Olfo Dusar Latha**
- commonName=**ndltman-dsamutb.spiegel**

Certificate issuer data is different for 5.61.34[.]51, but it follows a similar style:

- countryName=**MU**
- localityName=**Port Louis**
- organizationName=**Ppoffi Sourinop Cooperative**
- organizationalUnitName=**ipeepstha and thicioi**
- commonName=**plledsaprell.Byargt9wailen.voting**

This type of issuer data is commonly seen for Dridex post-infection  traffic. In our next example, you can further practice reviewing  certificate issuer data for Dridex.

**Example 5: Evaluation**

The fifth pcap for this tutorial, ***Ursnif-traffic-example-5.pcap\***, is available [here](https://www.malware-traffic-analysis.net/training/examining-ursnif.html). Like our previous example, this pcap has an Ursnif infection followed  by Dridex, so we can practice the skills described so far in this  tutorial.

Based on what we have learned so far, open the fifth pcap in Wireshark, and answer the following questions:

- For the initial Ursnif binary, which URL returned a Windows executable file?
- After the initial Ursnif binary was sent, the infected Windows host  contacted different domains for the HTTP GET requests. Which domain was  the traffic successful and allowed the infection to proceed?
- What domain was used in HTTPS traffic after Ursnif became persistent on the infected Windows host?
- What URL ending in .rar was used to send follow-up malware to the infected Windows host?
- What IP addresses were used for the Dridex post-infection traffic?

Answers follow.

**Q:** For the initial Ursnif binary, which URL returned a Windows executable file?

**A:** hxxp://ritalislum[.]com/obedle/zarref.php?l=sopopf8.cab

The only Windows executable file in this pcap is the initial Windows  executable file for Ursnif. Use the following Wireshark search filter to quickly find this executable:

***ip contains "This program"\***

This filter should provide only one frame in the results. Follow the TCP stream for this frame as shown in Figure 24.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-65.jpeg)Figure 24. Filtering to find a frame with the Windows executable file and following the TCP stream.*

The TCP stream window contains the domain and URL from the GET request as shown in Figure 25.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-66.jpeg)Figure 25. URL info from the TCP stream.*

**Q:** After the initial Ursnif binary was sent, the  infected Windows host contacted different domains for the HTTP GET  requests. Which domain was the traffic successful and allowed the  infection to proceed?

**A:** k55gaisi[.]com

Use your ***basic\*** web filter for an overview of the web traffic. HTTP requests caused by this variant of Ursnif start with GET /images/ as already seen in examples two, three, and four of this tutorial. The first HTTP request to k55gaisi[.]com at 15:36 UTC is noted in Figure 26. But if you follow the TCP stream, it shows a 404 Not Found as the response.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-67.jpeg)*Figure 26. Searching web traffic for HTTP GET requests caused by Ursnif.*

Also shown in Figure 26, the next HTTP GET request for an Ursnif-style URL is to bon11ljgarry[.]com at 15:37 UTC. The HTTP stream for that request reveals a redirect to a URL at www.search-error[.]com.

Scroll down further, and for similar traffic to leinwqoa[.]com as noted in Figure 27.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-68.jpeg)Figure 27. Finding another Ursnif-style URL that redirects to a search error page.*

Scroll down further to find four HTTP GET requests to k55gaisi[.]com that return 200 OK responses. From this point, the Ursnif infection  proceeds, and we find no further Ursnif-style HTTP requests that start  with GET /images/.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-69.jpeg)Figure 28. Finding the Ursnif-style HTTP GET requests that return a 200 OK.*

**Q:** What domain was used in HTTPS traffic after Ursnif became persistent on the infected Windows host?

**A:** n9maryjanef[.]com

When Ursnif is persistent, we no longer see Ursnif-style HTTP requests starting with GET /images/. Instead, we find Ursnif-related HTTPS traffic. Shortly after the final Ursnif-style HTTP GET request, HTTPS traffic to n9maryjanef[.]com begins on 185.118.165[.]109 as highlighted in Figure 29. This is Ursnif traffic.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-70.jpeg)Figure 29. HTTPS traffic caused by Ursnif.*

You can confirm this is Ursnif traffic by filtering on ***ip.addr eq 185.118.165.109 and ssl.handshake.type == 11\*** and reviewing the certificate issuer data. The certificate issuer data should look the same as our second example in Figure 10.

**Q:** What URL ending in .rar was used to send follow-up malware to the infected Windows host?

**A:** hxxps://testedsolutionbe[.]com/wp-content/plugins/apikey/uaasdqweeeeqsd.rar

HTTP GET requests caused by Ursnif for follow-up malware end in .rar, so use the following filter to find this URL in our pcap:

***http.request and ip contains .rar\***

The results should be similar to what we see in Figure 30.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-71.jpeg)Figure 30. Finding the URL for follow-up malware from this Ursnif infection.*

Notice in Figure 30 how the HTTP GET request in Figure 30 redirects to an HTTPS URL.

**Q:** What IP addresses were used for the Dridex post-infection traffic?

**A:** 185.99.133[.]38 and 5.61.34[.]51

One of these IP addresses is the same as Dridex in our fourth pcap,  and it has the same certificate issuer data. Dridex traffic to 185.99.133[.]38 has the same style of certificate issuer data as seen in example 4.  Traffic to both IP addresses does not involve a domain name.

The Dridex post-infection traffic is easy to spot in this example if  we look for any HTTPS/SSL/TLS traffic without a domain after the HTTP  GET request ending in .rar as shown in Figure 31.

*![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2019/12/word-image-72.jpeg)Figure 31. Finding the Dridex traffic in our fifth pcap.*

### Examining Qakbot Infections

[Qakbot](https://www.microsoft.com/en-us/wdsi/threats/malware-encyclopedia-description?Name=Win32%2FQakbot) is an information stealer also known as Qbot. This family of malware  has been active for years, and Qakbot generates distinct traffic  patterns. This [Wireshark](https://www.wireshark.org)  tutorial reviews a recent packet capture (pcap) from a Qakbot infection. Understanding these traffic patterns can be critical for security  professionals when detecting and investigating Qakbot infections.

Note: This tutorial assumes you have a basic knowledge of network  traffic and Wireshark. We use a customized column display shown in [this tutorial](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/). You should also have experience with Wireshark display filters as described in [this additional tutorial](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/).

Please also note that the pcap used for this tutorial contains  malware. You should review this pcap in a non-Windows environment. If  you are limited to a Windows computer, we suggest reviewing the pcap  within a virtual machine (VM) running any of the popular recent Linux  distros.

This tutorial will cover the following:

- - Qakbot distribution methods
  - Initial zip archive from link in an malspam
  - Windows executable for Qakbot
  - Post-infection HTTPS activity
  - Other post-infection traffic

The pcap used for this tutorial is located [here](https://www.malware-traffic-analysis.net/2020/01/29/index.html). Download the zip archive named ***2020-01-29-Qbot-infection-traffic.pcap.zip\*** and extract the pcap. Figure 1 shows our pcap open in Wireshark, ready to review.

![Qakbot Infection Traffic](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/PB-210-image-01-1024x641.jpg)Figure 1. The pcap for this tutorial.

**Qakbot Distribution Methods**

Qakbot is most often distributed through malicious spam (malspam), but it also has been distributed through exploit kits [as recently as November 2019](https://www.malware-traffic-analysis.net/2019/11/25/index3.html). In some cases, Qakbot is a follow-up infection caused by different malware like [Emotet](https://www.us-cert.gov/ncas/alerts/TA18-201A) as reported in [this example from March 2019](https://isc.sans.edu/forums/diary/Malspam+pushes+Emotet+with+Qakbot+as+the+followup+malware/24738/).

Recent malspam-based distribution campaigns for Qakbot follow a chain of events shown in Figure 2.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-29-1024x618.jpeg)Figure 2. Flow chart from recent Qakbot distribution campaigns.

**Initial Zip Archive from Link in Malspam**

Recent malspam distributing Qakbot uses fake email chains that spoof  legitimate email addresses. One such example is shown in Figure 3.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-30-1024x821.jpeg)Figure 3. Recent malspam example pushing Qakbot.

URLs from these emails end with a short series of numbers followed by ***.zip\***. See Table 1 for a few examples of URLs from Qakbot malspam recently reported on [URLhaus](https://urlhaus.abuse.ch/browse/) and [Twitter](https://twitter.com/search?q=Qakbot zip&f=live).

| **First reported** | **URL for initial zip archive**                              |
| ------------------ | ------------------------------------------------------------ |
| 2019-12-27         | hxxps://prajoon.000webhostapp[.]com/wp-content/uploads/2019/12/last/033/033.zip |
| 2019-12-27         | hxxps://psi-uae[.]com/wp-content/uploads/2019/12/last/870853.zip |
| 2019-12-27         | hxxps://re365[.]com/wp-content/uploads/2019/12/last/85944289/85944289.zip |
| 2019-12-27         | hxxps://liputanforex.web[.]id/wp-content/uploads/2019/12/last/794/794.zip |
| 2020-01-06         | hxxp://eps.icothanglong.edu[.]vn/forward/13078.zip           |
| 2020-01-22         | hxxp://hitechrobo[.]com/wp-content/uploads/2020/01/ahead/84296848/84296848.zip |
| 2020-01-22         | hxxp://faithoasis.000webhostapp.com/wp-content/uploads/2020/01/ahead/550889.zip |
| 2020-01-27         | hxxps://madisonclubbar[.]com/fast/invoice049740.zip          |
| 2020-01-29         | hxxp://zhinengbao[.]wang/wp-content/uploads/2020/01/lane/00571.zip |
| 2020-01-29         | hxxp://bhatner[.]com/wp-content/uploads/2020/01/ahead/9312.zip |
| 2020-02-03         | hxxp://santedeplus[.]info/wp-content/uploads/2020/02/ending/1582820/1582820.zip |

*Table 1. URLs for the initial zip archive to kick off a Qakbot infection chain.*

In our pcap, you can find the HTTP request for a zip archive using ***http.request.uri contains .zip\*** in the Wireshark filter as shown in Figure 4.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-31-1024x263.jpeg)Figure 4. Finding the URL for the initial zip archive.

Follow the TCP stream to confirm this is a zip archive as shown in  Figure 5 and Figure 6, then try to export the zip archive from the pcap  as shown in Figure 7.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-32-1024x657.jpeg)Figure 5. Following the TCP stream for the HTTP request from our filter results.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-33-1024x750.jpeg)Figure 6. Indicators this URL returned a zip archive.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-34-1024x663.jpeg)Figure 7. Exporting objects from HTTP traffic in the pcap.

In most cases, the menu for ***File → Export Objects → HTTP\*** should export a zip archive sent over HTTP. Unfortunately, as shown in Figure 8, we cannot export this file named ***9312.zip\*** because it is separated into hundreds of smaller parts within the export HTTP objects list.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-35-1024x757.jpeg)Figure 8. 9312.zip is broken up into hundreds of objects within the list, so we cannot export it this way.

Fortunately, we can export data from a TCP stream window and edit the binary in a hex editor to remove any hxxP response headers. Use the  following steps to extract the zip archive from this pcap:

1. 1. Follow TCP stream for the HTTP request for 9312.zip.
   2. Show only the response traffic in the TCP stream Window.
   3. Change “Show and save data as” from ASCII to Raw.
   4. Save the data as a binary (I chose to save it as: 9312.zip.bin)
   5. Open the binary in a hex editor and remove the HTTP request headers  before the first two bytes of the zip archive (which show as PK in  ASCII).
   6. Save the file as a zip archive (I chose to save it as 9312.zip)
   7. Check the file to make sure it’s a zip archive.

See Figures 9 through 14 for a visual guide of this process.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-36-1024x675.jpeg)Figure 9. Step 2 - When viewing the TCP stream, switch from viewing the entire conversation to viewing only data returned from the server.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-37-1024x771.jpeg)Figure 10. Step 3 - Show and save data as Raw instead of ASCII.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-38-1024x645.jpeg)Figure 11. Step 4 - Save this raw data from the TCP stream as a binary.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-39-1024x609.jpeg)Figure 12. Step 5 - Open your saved binary in a hex editor and remove any HTTP response data before the first two bytes of the zip archive (that show  as PK in ASCII).

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-40-1024x616.jpeg)Figure 13. Step 6 - Save your edited binary as a zip archive.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-41-1024x476.jpeg)Figure 14. Step 7 - Confirm the edited file is a zip archive, then extract the VBS file and check the file hashes.

Figure 14 shows how to use a terminal window from a Debian-based  Linux distro to check the files. From our pcap, the zip archive should  be the same as [this file submitted to VirusTotal](https://www.virustotal.com/gui/file/5121c89e898eadeff9eeef660d92f3cff75700c7f017b33c913a951018a3df9a). Our extracted VBS file should be the same as [this file also submitted to VirusTotal](https://www.virustotal.com/gui/file/51758a9ddf92d19be7c69a60125fb3dfc303152e9bbc77478dfff497422f3d25).

A public sandbox analysis of [our extracted VBS file](https://app.any.run/tasks/e2c36659-1070-4665-991c-245e900245b7) indicates it generates the next Qakbot-related URL in our infection chain: a URL that returned a Windows executable for Qakbot.

**Windows Executable for Qakbot**

These extracted VBS files generate URLs that return Windows  executables for Qakbot. Since December 2019, URLs for Qakbot executables have ended with 44444.png or 444444.png. See Table 2 for some recent examples of these Qakbot URLs we found using our [AutoFocus](https://www.paloaltonetworks.com/cortex/autofocus) Threat Intelligence service.

| **First Seen** | **URL for Qakbot executable**                                |
| -------------- | ------------------------------------------------------------ |
| 2019-12-27     | hxxp://centre-de-conduite-roannais[.]com/wp-content/uploads/2019/12/last/444444.png |
| 2020-01-06     | hxxp://newsinside[.]info/wp-content/uploads/2020/01/forward/44444.png |
| 2020-01-15     | hxxp://iike.xolva[.]com/wp-content/themes/keenshot/fast/444444.png |
| 2020-01-17     | hxxp://deccolab[.]com/fast/444444.png                        |
| 2020-01-21     | hxxp://myrestaurant.coupoly[.]com/wp-content/uploads/2020/01/along/444444.png |
| 2020-01-22     | hxxp://alphaenergyeng[.]com/wp-content/uploads/2020/01/ahead/444444.png |
| 2020-01-23     | hxxp://claramohammedschoolstl[.]org/wp-content/uploads/2020/01/upwards/444444.png |
| 2020-01-23     | hxxp://creationzerodechet[.]com/choice/444444.png            |
| 2020-01-26     | hxxp://productsphotostudio[.]com/wp-content/uploads/2020/01/lane/444444.png |
| 2020-01-27     | hxxp://sophistproduction[.]com/wp-content/uploads/2020/01/choice/444444.png |
| 2020-01-30     | hxxp://uofnpress[.]ch/wp-content/uploads/2020/01/side/444444.png |
| 2020-02-03     | hxxp://csrkanjiza[.]rs/wp-content/uploads/2020/02/ending/444444.png |

*Table 2. URLs for Qakbot executables.*

In our pcap, find the HTTP GET request for our Qakbot executable using ***hxxp.request.uri contains .png\*** in the Wireshark filter as shown in Figure 15.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-42-1024x258.jpeg)Figure 15. Finding the URL for our Qakbot executable.

Export this object from the pcap using the ***File → Export Objects → HTTP\*** menu path as shown in Figure 16 and check the results as shown in Figure 17.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-43-1024x506.jpeg)Figure 16. Exporting our Qakbot executable from the pcap.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-44-1024x276.jpeg)Figure 17. Checking the exported file in a Debian-based Linux terminal window.

From our pcap, the Qakbot executable should be [this file submitted to VirusTotal](https://www.virustotal.com/gui/file/56ee803fa903ab477f939b3894af6771aebf0138abe38ae8e3c41cf96bbb0f2a). A [public sandbox analysis of this file](https://app.any.run/tasks/fb9cffb1-7797-4827-8446-05fee3d6a3de) generated several Qakbot indicators (identified as Qbot).

**Post-infection HTTPS Activity**

Use your basic filter (covered in [this previous WIreshark tutorial](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/)) for a quick view of web traffic in our pcap. Scroll down to activity after the HTTP GET request to alphaenergyeng[.]com that returned our Qakbot executable. You should see several indicators of HTTPS or SSL/TLS traffic to 68.1.115[.]106 with no associated domain as noted in Figure 18.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-45-1024x608.jpeg)Figure 18. HTTPS or SSL/TLS traffic caused by Qakbot.

This traffic has unusual certificate issuer data commonly noted  during Qakbot infections. We reviewed unusual certificate issuer data in our [previous WIreshark tutorial about Ursnif](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/), so this should be easy to find.

Let’s review our Qakbot certificate issuer data using the following Wireshark filter:

***Ip.addr eq 68.1.115.186 and ssl.handshake.type eq 11\***

For Wireshark 3.0 or newer, use ***tls.handshake.type\*** instead of ***ssl.handshake.type\***. Select the first frame in your results and expand the frame details  window until you find the certificate issuer data as shown in Figure 19.

![Qakbot Infections](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-46-1024x723.jpeg)Figure 19. Reviewing certificate issuer data from Qakbot traffic.

Patterns for the locality name, organization name, and common name  are highly-unusual, not normally found in certificates from legitimate  HTTPS, SSL, or TLS traffic. Our example of this issuer data is listed  below:

- - id-at-countryName=**ES**
  - id-at-stateOrProvinceName=**IA**
  - id-at-localityName=**Uorh Ofwa**
  - id-at-organizationName=**Coejdut Mavmtko Qxyemk Dxsjie LLC.**
  - id-at-commonName=**gaevietovp.mobi**

**Other Post-infection Traffic**

Our pcap contains other activity associated with a Qakbot infection.  Each activity is not inherently malicious on its own, but taken together with our previous findings, we can assume a full Qakbot infection.

Another indicator of a Qakbot infection is HTTPS traffic to cdn.speedof[.]me. The domain speedof[.]me is used by a legitimate Internet speed test service. Although this is not malicious traffic, we frequently see traffic to cdn.speedof[.]me during Qakbot infections. Figure 20 shows this activity from our pcap.



![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-47-1024x622.jpeg)Figure 20. The domain cdn.speedof[.]me within the Qakbot traffic.

Qakbot also opens windows from all browsers on an infected Windows host. At approximately 13 minutes and 5 seconds into [this sandbox analysis](https://app.any.run/tasks/fb9cffb1-7797-4827-8446-05fee3d6a3de), the video playback shows Qakbot opening Chrome, then Firefox, then  Internet Explorer on a Windows 7 host. This analysis shows Qakbot  generated traffic to the following URLs:



- hxxp://store.nvprivateoffice[.]com/redir_chrome.html
- hxxp://store.nvprivateoffice[.]com/redir_ff.html
- hxxp://store.nvprivateoffice[.]com/redir_ie.html

The domain nvprivateoffice[.]com has been registered through GoDaddy since 2012, and store.nvprivateoffice[.]com shows a default web page for nginx on a Fedora server.

Our pcap for this tutorial is from a Qakbot infection on a Windows 10 host without Chrome or Firefox installed. Our pcap only shows web  traffic for Internet Explorer and the new Chromium-based Microsoft Edge. Both times, the URL generated by Qakbot was hxxp://store.nvprivateoffice[.]com/redir_ie.html.

To find this traffic, use the following Wireshark filter as shown in Figure 21:

***http.request.full_uri contains store.nvprivateoffice***

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-48-1024x315.jpeg)Figure 21. Finding Qakbot traffic that opens web browsers on an infected Windows host.

Follow the TCP stream for each of the two HTTP GET requests ending in redir_ie.html. The first request has a User-Agent in the HTTP headers for Internet  Explorer as shown in Figure 22. The second request for the same URL has a User-Agent in the HTTP headers for the new Chromium-based Microsoft  Edge as noted in Figure 23.



![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-49-1024x757.jpeg)Figure 22. Qakbot traffic to store.nvprivateoffice[.]com using Internet Explorer 11.

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-50-1024x758.jpeg)Figure 23. Qakbot traffic to store.nvprivateoffice[.]com using the new Chromium-based Microsoft Edge.

Finally, our pcap from the Qakbot-infected host also has email-related TCP  traffic to various ports for various email protocols like SMTP, IMAP,  and POP3. To get an idea of this non-web-related traffic, use the  following Wireshark filter as shown in Figure 25:



***tcp.flags eq 0x0002 and !(tcp.port eq 80) and !(tcp.port eq 443)\***

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-51-1024x864.jpeg)Figure 25. Getting an idea of the non-web-related traffic from this Qakbot infection.

Figure 25 shows TCP connections and attempted TCP connections to  various ports like 25, 110,143, 465, 587, 993, and 995 commonly used by  different email protocols. The first two lines in the results show  traffic to TCP port 65400, but reviewing the associated TCP streams  indicates this also email-related traffic.

Use the following Wireshark filter to get a better idea of email-related traffic from the infected host as shown in Figure 26:

***smtp or imap or pop\***

![img](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/02/word-image-52-1024x628.jpeg)Figure 26. Finding email-related traffic caused by Qakbot in this pcap.

Follow some of the TCP streams to get a better idea for this type of  email traffic. We do not normally see such unencrypted email traffic  originating from a Windows client to public IP addresses. Along with  other indicators, this ***smtp or imap or pop\*** filter may reveal Qakbot activity.

### Decrypting HTTPS Traffic

This tutorial is designed for security professionals who investigate  suspicious network activity and review packet captures (pcaps) of the  traffic. The instructions assume you are familiar with [Wireshark](https://www.wireshark.org/), and it focuses on Wireshark version 3.x.

When reviewing suspicious network activity, we often run across  encrypted traffic. Why? Because most websites use the Hypertext Transfer Protocol Secure (HTTPS) protocol. But like most websites, various types of malware also use HTTPS. When reviewing pcaps from malware activity,  it’s very helpful to know what’s contained within post-infection  traffic.

This Wireshark tutorial describes how to decrypt HTTPS traffic from a pcap in Wireshark. Decryption is possible with a text-based log  containing encryption key data captured when the pcap was originally  recorded. With this key log file, we can decrypt HTTPS activity in a  pcap and review its contents.

Today, we will examine HTTPS activity from a [Dridex](https://en.wikipedia.org/wiki/Dridex) malware infection.

Note: Our instructions assume you have customized your Wireshark column display as previously described in “[Customizing Wireshark – Changing Your Column Display](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/).”.

Here is a Github repository with a ZIP archive containing the [pcap and a key log file used for this tutorial](https://github.com/pan-unit42/wireshark-tutorial-decrypting-HTTPS-traffic).

**Warning:** The pcap used for this tutorial contains Windows-based malware. There  is a risk of infection if using a Windows computer. We recommend you  review this pcap in a non-Windows environment like BSD, Linux or macOS  if at all possible.

**The Context Behind Encrypted Traffic**

In the mid- to late-1990s, the most common protocol used by websites  was Hypertext Transfer Protocol (HTTP), which generated unencrypted web  traffic. However, as security became an increasing concern, websites  started switching to HTTPS, and now we rarely see HTTP traffic from web  browsing.

HTTPS is essentially an encrypted communications tunnel containing  HTTP traffic. These tunnels first used Secure Sockets Layer (SSL) as an  encryption protocol. Today most HTTPS traffic uses Transport Layer  Security (TLS).

**HTTPS Web Traffic**

HTTPS traffic often reveals a domain name. For example, when viewing https://www.wireshark.org in a web browser, a pcap would show www.wireshark.org as the server name for this traffic when viewed in a [customized Wireshark column display](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/). Unfortunately, we don’t know other details like the actual URL or data  returned from the server. Following the Transmission Control Protocol  (TCP) stream from a pcap will not reveal the content of this traffic  because it is encrypted.

![The screenshots show what is seen when viewing https://www.wireshark.org in a web browser, vs. what a pcap would show when viewed in a customized Wireshark column display. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image.jpeg)Figure 1. Traffic from HTTPS traffic to www.wireshark.org.

![Wireshark - Follow TCP Stream (tcp.stream eq0) - Ethernet0](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-1.jpeg)Figure 2. TCP stream of HTTPS traffic to and from server at www.wireshark.org.

**Encryption Key Log File**

An encryption key log is a text file. An example is shown in Figure 3.

![Wireshark-tutorial-KeysLogFile.txt - Mousepad](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-2.jpeg)Figure 3. The key log file used in this tutorial.

These logs are created using a Man in the Middle (MitM) technique  when the pcap is originally recorded. If no such file was created when  the pcap was recorded, you cannot decrypt HTTPS traffic in that pcap.

**Example of a Pcap With a Key Log File**

A password-protected ZIP archive containing the pcap and its key log file is available at [this Github repository](https://github.com/pan-unit42/wireshark-tutorial-decrypting-HTTPS-traffic). Go to the Github page, click on the ZIP archive entry, then download it as shown in Figures 4 and 5. Of note, the pcap contained in this ZIP  archive provides access to a Windows-based malware sample when decrypted with the key log. As always, we recommend you exercise caution and  follow steps from this tutorial in a non-Windows environment.

![pan-unit42/wireshark-tutorial-decrypting-HTTPS-traffic - the screenshot shows the Github repository with the link to the ZIP archive used for this tutorial on decrypting HTTPS traffic. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-3.jpeg)Figure 4. Github repository with link to ZIP archive used for this tutorial.

![pan-unit42/wireshark-tutorial-decrypting-HTTPS-traffic - the screenshot shows how downloading the ZIP archive used for this tutorial on decrypting HTTPS traffic works in the Github repository. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-4.jpeg)Figure 5. Downloading the ZIP archive for this tutorial.

Use ***infected\*** as the password to extract the pcap and key log file from the ZIP archive. This will provide two files as shown in Figure 6:

- Wireshark-tutorial-KeysLogFile.txt
- Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.pcap

![Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.zip - These screenshots show how to unzip the ZIP archive used for this tutorial on decrypting HTTPS traffic. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-5.jpeg)Figure 6. Key log file and pcap for this tutorial.

**HTTPS Traffic Without the Key Log File**

Open ***Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.pcap\*** in Wireshark. Use a basic web filter as described in this previous [tutorial about Wireshark filters](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/). Our basic filter for Wireshark 3.x is:

(http.request or tls.handshake.type eq 1) and !(ssdp)

This pcap is from a Dridex malware infection on a Windows 10 host.  All web traffic, including the infection activity, is HTTPS. Without the key log file, we cannot see any details of the traffic, just the IP  addresses, TCP ports and domain names, as shown in Figure 7.

![Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.zip - This screenshot shows the pcap from the tutorial on decrypting HTTPS traffic when viewed in Wireshark using the basic web filter without any decryption. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-6.jpeg)Figure 7. Viewing the pcap in Wireshark using the basic web filter without any decryption.

**Loading the Key Log File**

Open ***Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.pcap\*** in Wireshark. Then use the menu path ***Edit --> Preferences\*** to bring up the Preferences Menu, as shown in Figure 8.

!["Open Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.pcap in Wireshark. Then use the menu path Edit --> Preferences to bring up the Preferences Menu, as shown here. "](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-7.jpeg)Figure 8. Getting to the Preferences Menu in Wireshark.

On the left side of the Preferences Menu, click on Protocols, as shown in Figure 9.

![On the left side of the Wireshark - Preferences Menu, click on Protocols, as shown here. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-8.jpeg)Figure 9. Selecting Protocols in the Preferences Menu.

If you are using Wireshark version 2.x, scroll down until you find ***SSL\*** and select it. If you are using Wireshark version 3.x, scroll down to ***TLS\*** and select it. Once you have selected SSL or TLS, you should see a line for ***(Pre)-Master-Secret log filename\***. Click on the “Browse” button and select our key log file named ***Wireshark-tutorial-KeysLogFile.txt\***, as shown in Figures 10, 11 and 12.

![Once you have selected TLS in Wireshark 3.x, you should see a line for (Pre)-Master-Secret log filename. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-9.jpeg)Figure 10. Finding the (Pre)-Master-Secret log filename field under TLS in Wireshark 3.x.

![To proceed with the tutorial on decrypting HTTPS traffic, select our key log file named Wireshark-tutorial-KeysLogFile.txt after clicking the "Browse" button. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-10.jpeg)Figure 11. Selecting our key log file for this tutorial.

![This shows how the screen appears in Wireshark once the key log file for the decrypting HTTPS traffic tutorial has been properly selected. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-11.jpeg)Figure 12. Once the file has been selected as the (Pre)-Master-Secret log filename, click “OK.”

**HTTPS Traffic With the Key Log File**

Once you have clicked “OK,” when using the basic filter, your  Wireshark column display will list the decrypted HTTP requests under  each of the HTTPS lines, as shown in Figure 13.

![This screenshot advances the decrypting HTTPS traffic tutorial by showing how your Wireshark column display will list decrypted HTTP requests under each of the HTTPS lines. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-12.jpeg)Figure 13. HTTPS decryption in Wireshark after using the key log file.

In this pcap, we now see HTTP requests to microsoft.com and skype.com domains previously hidden in the HTTPS traffic. We also find the following traffic caused by the Dridex infection:

- foodsgoodforliver[.]com - GET /invest_20.dll
- 105711[.]com - POST /docs.php

The GET request to foodsgoodforliver[.]com returned a DLL file for Dridex. The POST requests to 105711[.]com are command and control (C2) traffic from the Dridex-infected Windows host.

We can review the traffic by following HTTP streams. Right-click on  the line to select it, then left-click to bring up a menu to follow the  HTTP stream. Figures 14 and 15 show following the HTTP stream for the  HTTP GET request to foodsgoodforliver[.]com.

![Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.pcap - this shows the series of clicks that allow you to follow the HTTP stream for the GET request to foodsgoodforliver[.]com](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-13.jpeg)Figure 14. Following HTTP stream for the GET request to foodsgoodforliver[.]com.

![Wireshark - Follow HTTP Stream (tcp.stream eq 2) - Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.pcap - the screenshot shows how the HTTP stream indicates an EXE or DLL returned from the server](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-14.jpeg)Figure 15. HTTP stream indicates an EXE or DLL returned from the server.

Since we have the key log file for this traffic, we can now export this malware from the pcap. Use the menu path ***File --> Export Objects --> HTTP\*** to export this file from the pcap, as shown in Figure 16.



![Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.pcap - the screenshot shows the series of clicks required to export the malware binary used as an example in the decrypting HTTPS traffic tutorial. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-15.jpeg)Figure 16. Exporting the malware binary returned from foodsgoodforliver[.]com.

If you are in a BSD, Linux or macOS environment, open a terminal window and use the file command to confirm this is a DLL file. Then use shasum -a 256 to get the SHA256 hash of the file, as shown in Figure 17.



![The screenshot from the decrypting HTTPS traffic tutorial shows how you can open a terminal window in a BSD, Linux or macOS environment, use the file command to confirm this is a DLL file, and then get the SHA256 hash of the file. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-16.jpeg)Figure 17. Getting the SHA256 hash of this malware in a Linux environment.

#### The SHA256 hash of this malware is:

31cf42b2a7c5c558f44cfc67684cc344c17d4946d3a1e0b2cecb8eb58173cb2f

If you [search for this hash](https://www.google.com/search?q=31cf42b2a7c5c558f44cfc67684cc344c17d4946d3a1e0b2cecb8eb58173cb2f) online, you should find results from at least two publicly available online sandbox environments.

Finally, we can review C2 traffic from this Dridex infection. Use  your basic web filter, then follow an HTTP stream from one of the POST  requests to 105711[.]com. An example from one of the HTTP streams is shown in Figure 18.

![Wireshark - Follow HTTP Stream (tcp.stream eq 5) - Wireshark-tutorial-on-decrypting-HTTPS-SSL-TLS-traffic.pcap - the screenshot shows the HTTP stream from one of the Dridex C2 POST requests. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/08/word-image-17.jpeg)Figure 18. HTTP stream from one of the Dridex C2 POST requests.

### Examining Dridex Infection Traffic

This tutorial is designed for security professionals who investigate  suspicious network activity and review network packet captures (pcaps).  Familiarity with [Wireshark](https://www.wireshark.org/) is necessary to understand this tutorial, which focuses on Wireshark version 3.x.

[Dridex](https://malpedia.caad.fkie.fraunhofer.de/details/win.dridex) is the name for a family of information-stealing malware that has also been described as a banking Trojan. This malware [first appeared in 2014](https://malpedia.caad.fkie.fraunhofer.de/details/win.dridex) and has been active ever since.

Today’s Wireshark tutorial reviews Dridex activity and provides some  helpful tips on identifying this family based on traffic analysis.

Note: Our instructions assume you have customized Wireshark as described in [our previous Wireshark tutorial about customizing the column display](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/).

You will need to access a GitHub repository with ZIP archives containing [pcaps used for this tutorial](https://github.com/pan-unit42/wireshark-tutorial-Dridex-traffic).

**Warning:** Some of the pcaps used for this tutorial contain Windows-based malware. There is a risk of infection if using a Windows computer. We recommend  you review this pcap in a non-Windows environment like BSD, Linux or  macOS if at all possible.

**Dridex Distribution**

To understand Dridex network traffic, you should understand the chain of events leading to an infection. Dridex is commonly distributed  through malicious spam (malspam). Waves of this malspam usually occur at least two or three times a week. Some emails delivering Dridex contain  Microsoft Office documents attached, while other emails contain links to download a malicious file. Figures 1 through 4 show some recent  examples.

![An email carrying a malicious Excel file, pushing Dridex, with the subject line "DHL Invoices for Aug 2020"](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-2.jpeg)Figure 1. From September 2020, DHL-themed malspam pushing Dridex using an attachment.

![An email pushing Dridex using an attached malicious Excel file. The subject line is "UPS Invoice Notification." ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-3.jpeg)Figure 2. From October 2020, UPS-themed malspam pushing Dridex using an attachment.

![An email pushing Dridex using a malicious link. The subject line is "FedEx Shipment 747958837531 Delivered." ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-4.jpeg)Figure 3. From September 2020, FedEx-themed malspam pushing Dridex using a link.

![An email pushing Dridex using a malicious link. The subject line is "Notification : invoice 796636." ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-5.jpeg)Figure 4. From October 2020, QuickBooks-themed malspam pushing Dridex using a link.

The initial malicious file can be a Microsoft Office document with a  malicious macro, or it could be a Windows executable (EXE) disguised as  some sort of document. Either way, potential victims need to click their way to an infection from this initial file. The initial file retrieves a Dridex installer, although sometimes the initial file is itself a  Dridex installer. The Dridex installer retrieves 64-bit Dridex DLL files over encrypted command and control (C2) network traffic. Figures 5 and 6 show what we commonly see for infection chains of recent Dridex  activity.

![Malspam with attached spreadsheets pushing Dridex. The chain of events is as follows: malspam with attachment, attached Excel spreadsheet, enable macros, HTTPS traffic for installer DLL, installer DLL for Dridex, HTTPS C2 traffic, 64-bit Dridex DLL files, HTTPS C2 traffic, updated 64-bit Dridex DLL files](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-6.jpeg)Figure 5. Chain of events commonly seen when Dridex is distributed as malspam attachments.

![Malspam with links pushing Dridex. Chain of events is commonly as follows: malspam with HTTPS link, HTTPS traffic for Word doc, downloaded Word doc, enable macros, HTTPS traffic for installer DLL, installer DLL for Dridex, HTTPS C2 traffic, 64-bit Dridex DLL files, HTTPS C2 traffic, updated 64-bit Dridex DLL files](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-7.jpeg)Figure 6. Chain of events commonly seen when Dridex is distributed using links in malspam.

Figure 7 shows another type of Dridex infection chain from malspam,  which is not as common as the Office documents used in Figures 5 and 6.  On Sept. 24, 2020, links from malspam pushing Dridex didn’t return an  Office document. Instead, they returned a Windows executable file. See  Figure 7 for details.

![Malspam pushing Dridex on Thursday 2020-09-24, Note: Occasionally, the same HTTPS link returned an EXE with an .scr file extension instead of a ZIP archive. The chain of events seen was as follows: malspam with HTTPS link, HTTPS traffic for ZIP archive, downloaded ZIP archive, Dridex installer EXE (.scr file extension), HTTPS C2 traffic, 64-bit Dridex DLL files, HTTPS C2 traffic, updated 64-bit Dridex DLL files](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-8.jpeg)Figure 7: Chain of events seen in September 2020 where the link led to a Dridex installer EXE.

As noted in Figures 5 through 7, distribution traffic is most often  HTTPS, which makes the initial file or Dridex installer hard to detect  because it is encrypted. Fortunately, post-infection traffic caused by  Dridex C2 activity is distinctive enough to identify.

**Certificates and HTTPS Traffic**

To understand Dridex infection activity, we should also understand digital certificates used for HTTPS traffic.

A digital certificate is used for SSL/TLS encryption of HTTPS  traffic. When viewing a website using HTTPS, a certificate is sent by  the web server to a client's web browser. Data from this digital  certificate is used to establish an HTTPS connection. Certificates  contain a website's public key and confirm the website's identity.

Different [certificate authorities](https://en.wikipedia.org/wiki/Certificate_authority) (CAs) can issue digital certificates for various websites. Certificates are sold to businesses for commercial websites, while some certificate  authorities like [Let’s Encrypt](https://letsencrypt.org/about/) offer certificates for free.

Certificate information can be viewed from HTTPS traffic in Wireshark. We’ll focus on the following two sections:

- Issuer data about the CA.
- Subject data about the website.

Issuer data reveals the CA that issued the digital certificate.  Subject data verifies the identity of the website. Figure 8 shows how to find certificate issuer and subject data for HTTPS traffic from www.paloaltonetworks.com.

![The screenshot shows how to find certificate issuer and subject date for HTTPS traffic, using www.paloaltonetworks.com as an example. A red box highlights the subject data to identify the website. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-9.jpeg)Figure 8. Certificate data from HTTPS traffic to www.paloaltonetworks.com.

However, when setting up a web server, administrators can generate  self-signed certificates. Self-signed certificates are locally generated and not issued by any certificate authority. HTTPS traffic from such  servers often generates error messages when viewed in modern browsers,  such as Firefox, as shown in Figure 9.

![HTTPS traffic from self-signed certificates often generates error messages when viewed in modern browsers, such as this warning from Firefox, which states, "Warning: Potential Security Risk Ahead." ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-10.jpeg)Figure 9. Error from Firefox when trying to view a page from a website that uses a self-signed certificate.

Malware developers often use self-signed certificates for their C2  servers. Why? Because self-signed certificates are quick, easy and free  to create. Furthermore, HTTPS C2 traffic for malware does not involve a  web browser, so the encrypted traffic works without any errors or  warnings.

Generating self-signed certificate involves entering values for the following fields (some of these are often left blank):

- Country name (2 letter code).
- State or province name.
- Locality name (usually a city name).
- Organization name.
- Organizational unit name.
- Common name (for example, fully qualified host name).
- Email address.

These fields are used for subject data that identifies the website,  but the same fields and values are also used for the issuer, since the  certificate was generated locally on the web server itself.

Malware authors often use random, default or fake values in these  fields for self-signed certificates. For example, Trickbot’s HTTPS C2  traffic often uses example.com for the Common Name field. [HTTPS C2 traffic from recent IcedID malware infections](https://www.malware-traffic-analysis.net/2020/10/06/index.html) has used the following values in its certificate issuer fields:

- Country name: AU
- State or province name: Some-State
- Organization name: Internet Widgits Pty Ltd
- Common name: localhost

Patterns in certificate issuer data for Dridex HTTPS C2 traffic are  somewhat unique when compared to other malware families. They can be key to identifying Dridex infections.

**Pcaps of Dridex Infection Activity**

Five password-protected ZIP archives containing pcaps of recent Dridex network traffic are available at [this GitHub repository](https://github.com/pan-unit42/wireshark-tutorial-Dridex-traffic). Once on the GitHub page, click on each of the ZIP archive entries, and download them as shown in Figures 10 and 11.

![This shows how to download the ZIP archive used for this tutorial from the GitHub repository, pan-unit42 / wireshark-tutorial-Dridex-traffic](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-11.jpeg)Figure 10. GitHub repository with links to ZIP archive used for this tutorial.

![The screenshot shows an example of downloading a ZIP archive, 2020-06-03-Dridex-infection-traffic-pcap.zip, from the GitHub repository storing files for this Wireshark tutorial](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-12.jpeg)Figure 11. Downloading one of the ZIP archives for this tutorial.

Use ***infected\*** as the password to extract pcaps from these ZIP archives. This will result in five pcap files:

- 2020-06-03-Dridex-infection-traffic.pcap
- 2020-09-24-Dridex-infection-traffic.pcap
- 2020-09-29-Dridex-infection-traffic.pcap
- 2020-10-05-Dridex-infection-traffic.pcap
- 2020-10-07-Dridex-infection-traffic.pcap

**Example One: 2020-06-03-Dridex-infection-traffic.pcap**

Open ***2020-06-03-Dridex-infection-traffic.pcap\*** in Wireshark, and use a basic web filter as described in this previous [tutorial about Wireshark filters](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/). Our basic filter for Wireshark 3.x is:

(http.request or tls.handshake.type eq 1) and !(ssdp)

Dridex infection traffic consists of two parts:

- Initial infection activity.
- Post-infection C2 traffic.

Initial infection activity occurs when a victim downloads a malicious file from an email link. Initial infection activity also includes the  malicious file loading an installer for Dridex. In some cases, you may  not have an initial download because the malicious file is an attachment from an email. In other cases, you might not see a Dridex installer  loaded because the initial file itself is an installer. In many cases,  this activity happens over HTTPS, so we will not see any URLs, just a  domain name.

Post-infection activity is HTTPS C2 traffic that occurs after the  victim is infected. This will always occur during a successful Dridex  infection. This C2 traffic communicates directly with an IP address, so  there are no domain names associated with it. It also has unusual  certificate issuer data as detailed below.

Figure 12 shows the first example opened in Wireshark using our basic web filter. The lines without a domain name are Dridex HTTPS C2  traffic.

![This screenshot shows Dridex infection traffic, filtered in Wireshark. The screen is labeled 2020-06-03-Dridex-infection-traffic.pcap](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-13.jpeg)Figure 12. Traffic from the first pcap filtered in Wireshark using our basic web filter.

The first pcap shown in Figure 12 shows the following traffic  directly to IP addresses instead of domain names. This is most likely  Dridex HTTPS C2 traffic:

- 185.86.148[.]68 over TCP port 443
- 212.95.153[.]36 over TCP port 453

Other domains seen using our basic web filter are system traffic using domains that end with well-known names like microsoft.com, office.net or windows.com. The only exception is HTTPS traffic to truepenesonga[.]com, which is near the beginning of the pcap at 19:38:18 UTC. This is likely the Dridex installer. A quick [Google search](https://www.google.com/search?q=truepenesonga+com+malware) indicates truepenesonga[.]com is associated with malware.

Focus on the post-infection Dridex C2 traffic. Use the following  filter in Wireshark to look at the certificate issuer data for HTTPS  traffic over these two IP addresses:

tls.handshake.type eq 11 and (ip.addr eq 185.86.148.68 or ip.addr eq 212.95.153.36)

After the filter has been applied, select the first frame in your  Wireshark column display, then go to the frame details panel and expand  the values as shown in Figure 13 until you work your way to a list of  lines that start with the term RDNSequence item.

![The screenshot highlights key spots that can be used for finding certificate issuer data for Dridex HTTPS C2 traffic. Red arrows particularly point out Transport layer security, certificate, handshake protocol, signed certfiicate, issuer and rdnSequence. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-14.jpeg)Figure 13. Finding certificate issuer data for Dridex HTTPS C2 traffic.

Note the RDNSequence items for HTTPS traffic to 185.86.148[.]68 and their values:

- id-at-countryName=Vu
- id-at-stateOrProvinceName=Uererarnk4
- id-at-localityName=Port Vila
- id-at-organizationName=Whensean Imegdtc SICAV
- id-at-organizationUnitName=6Tbuthinalq
- id-at-commonName=1andfhtittbly.fan

Dridex certificate issuer fields frequently has random strings with a number or two sometimes thrown in. However, values for the country name and city or locality often match. In the above example, Vu is the 2-letter country code for Vanuatu, and Port Vila is the capital city of Vanuatu.

Do the same thing for HTTPS traffic to 212.95.153[.]36 and you should find:

- id-at-countryName=AO
- id-at-localityName=Luanda
- id-at-organizationName=Msorest KGaA
- id-at-organizationUnitName=aghat@yongd
- id-at-commonName=arashrinwearc.Ourontizes.ly

We find the locality Luanda is the capital of Angola, which is country code AO. But the other fields appear to have random values. This type of  certificate issuer data is a strong indicator of Dridex C2 traffic.

**Example Two: 2020-09-24-Dridex-infection-traffic.pcap**

Open ***2020-09-24-Dridex-infection-traffic.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 14.

![This screenshot shows Dridex infection traffic, filtered in Wireshark. The screen is labeled 2020-09-24-Dridex-infection-traffic.pcap](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-15.jpeg)Figure 14. Traffic from the second pcap filtered in Wireshark using our basic web filter.

Note how the first three lines are unencrypted HTTP GET requests.  This is a link from an email shown earlier in Figure 3. It returned a  ZIP archive for the infection chain shown in Figure 7.

The HTTP stream (not the TCP stream) can be followed. Scroll down to see some script returned, as shown in Figures 15 and 16.

![The HTTP stream (not the TCP stream) can be followed. The screenshot indicates how to find that option in Wireshark. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-16.jpeg)Figure 15. Following the HTTP stream for the first HTTP GET request.

![When following the HTTP Stream for the Dridex infection traffic, scroll down to view the script returned from the first HTTP GET request. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-17.jpeg)Figure 16. Scroll down to view the script returned from that HTTP GET request.

All three HTTP GET requests to adv.epostoday[.]uk are in the same TCP stream. Scroll down near the end before the last HTTP GET request for  favicon.ico. You will find the end of a long string of ASCII characters  that is converted to a blob and sent to the victim as Ref_Sep24-2020.zip, as shown in Figure 17.

![A red arrow indicates Ref_Sept24-2020.zip, the ZIP archive that the victim will be encouraged to save from the browser. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-18.jpeg)Figure 17. Script is designed to present a ZIP archive to the victim to save from the browser.

These scripts can be exported by using the ”export HTTP objects” function, as shown in Figure 18.

![Using the "export HTTP objects" function, it is possible to save the scripts returned from URLs ending in app.php. Red arrows indicate the options to select. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-19.jpeg)Figure 18. Saving the scripts returned from URLs ending in app.php.

Once again, focus on the post-infection Dridex C2 traffic. Use the  following filter in Wireshark to look at the certificate issuer data for HTTPS traffic over the two IP addresses without domain names in the  HTTPS traffic:

tls.handshake.type eq 11 and (ip.addr eq 151.236.219.181 or ip.addr eq 62.98.109.30)

After applying the filter, select the first frame and go to the frame details section. Look for a list of lines that start with the term RDNSequence item as done in our first pcap. Figure 19 shows how to get there in our second pcap for 151.236.219[.]181.

![The screenshot highlights key spots that can be used for finding certificate issuer data for Dridex HTTPS C2 traffic. Red arrows particularly point out Transport layer security, certificate, handshake protocol, signed certfiicate, issuer and rdnSequence. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-20.jpeg)Figure 19. Finding certificate issuer data for Dridex HTTPS C2 traffic in our second pcap.

The certificate issuer data is similar to that of the first example.  Check the certificate issuer data for both IP addresses and find the  data listed below.

Certificate issuer data for Dridex HTTPS C2 traffic on 151.236.219[.]181:

- id-at-countryName=IL
- id-at-stateOrProvinceName=Anourd Thiolaved Thersile5 Fteda8
- id-at-LocalityName=Tel Aviv
- id-at-organizationName=Wemadd Hixchac GmBH
- id-at-organizationUnitName=moasn@emanc
- id-at-commonName=heardbellith.Icanwepeh.nagoya

Certificate issuer data for Dridex HTTPS C2 traffic on 62.98.109[.]30:

- id-at-countryName=SS
- id-at-LocalityName=Khartoum
- id-at-organizationName=Hedanpr S.p.a.
- id-at-commonName=psprponounst.aquarelle

The locality matches the country name in both cases, but the other  fields appear to be random strings. This matches the same pattern as  Dridex HTTPS C2 traffic from our first pcap.

**Example Three: 2020-09-29-Dridex-infection-traffic.pcap**

Open ***2020-09-29-Dridex-infection-traffic.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 20.

![This screenshot shows Dridex infection traffic, filtered in Wireshark. The screen is labeled 2020-09-29-Dridex-infection-traffic.pcap](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-21.jpeg)Figure 20. Traffic from the third pcap filtered in Wireshark using our basic web filter.

Checking through the domains, there are three non-Microsoft domains  using HTTPS traffic that might be tied to the initial infection  activity:

- dsimportaciones[.]com
- murfreesboro.fairwayconcierge[.]com
- ryner.net[.]au

Since those are URL-specific and the contents are not shown, focus on the post-infection Dridex C2 traffic. Use the following filter in  Wireshark to look at the certificate issuer data for HTTPS traffic over  the two IP addresses without domain names in the HTTPS traffic:

tls.handshake.type eq 11 and (ip.addr eq 67.79.105.174 or ip.addr eq 144.202.31.138)

After applying the filter, select the first frame, go to the frame  details section and look for a list of lines that start with the term RDNSequence item as done in our first two examples. Figure 21 shows how to get there in our third pcap for 67.79.105[.]174.

![The screenshot highlights key spots that can be used for finding certificate issuer data for Dridex HTTPS C2 traffic. Red arrows particularly point out Transport layer security, certificate, handshake protocol, signed certfiicate, issuer and rdnSequence. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-22.jpeg)Figure 21. Finding certificate issuer data for Dridex HTTPS C2 traffic in our third pcap.

The certificate issuer data follows the same pattern as our first two examples. Check the issuer data for both IP addresses to find the data  listed below.

Certificate issuer data for Dridex HTTPS C2 traffic on 67.79.105[.]174:

- id-at-countryName=MN
- id-at-stateOrProvinceName=Listth Thearere8 berponedt tithsalet
- id-at-LocalityName=Ulaanbaatar
- id-at-organizationName=Massol SE
- id-at-commonName=Atid7brere.Speso_misetr.stada

Certificate issuer data for Dridex HTTPS C2 traffic on 144.202.31[.]138:

- id-at-countryName=SS
- id-at-LocalityName=Khartoum
- id-at-organizationName=Hedanpr S.p.a.
- id-at-commonName=psprponounst.aquarelle

Of note, certificate issuer data for 144.202.31[.]138 in the third example from 2020-09-29 is the same as for 62.98.109[.]30 in the second example from 2020-09-24.

**Example Four: 2020-10-05-Dridex-infection-traffic.pcap**

Open ***2020-10-05-Dridex-infection-traffic.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 22.

![This screenshot shows Dridex infection traffic, filtered in Wireshark. The screen is labeled 2020-10-05-Dridex-infection-traffic.pcap](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-23.jpeg)Figure 22. Traffic from the fourth pcap filtered in Wireshark using our basic web filter.

Checking through the domains, there is one non-Microsoft domain using HTTPS traffic that might be tied to the initial infection activity:

- vardhmanproducts[.]com

Once again, the focus will be on post-infection Dridex C2 traffic.  Use the following filter in Wireshark to look at the certificate issuer  data for HTTPS traffic over the two IP addresses without domain names in the HTTPS traffic:

tls.handshake.type eq 11 and (ip.addr eq 85.114.134.25 or ip.addr eq 85.211.162.44)

After applying the filter, select the first frame, go to the frame  details section and work your way to a list of lines that start with the term RDNSequence item as done in the first three examples.

The certificate issuer data follows the same pattern as the first  three examples. Check the issuer data for both IP addresses, and you  should find the data listed below.

Certificate issuer data for Dridex HTTPS C2 traffic on 85.114.134[.]25:

- id-at-countryName=NZ
- id-at-stateOrProvinceName=Cepli thade0 ithentha temsorer
- id-at-LocalityName=Wellington
- id-at-organizationName=Lling Lovisq NL
- id-at-organizationalUnitName=Punddtln
- id-at-commonName=Onshthonese.vyrda-npeces.post

Certificate issuer data for Dridex HTTPS C2 traffic on 85.211.162[.]44:

- id-at-countryName=MY
- id-at-LocalityName=Kuala Lumpur
- id-at-organizationName=Ointavi Tagate Unltd.
- id-at-commonName=Ateei7thapom.statonrc.loan

**Example Five: 2020-10-07-Dridex-infection-traffic.pcap**

Open ***2020-10-07-Dridex-infection-traffic.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 23.

![This screenshot shows Dridex infection traffic, filtered in Wireshark. The screen is labeled 2020-10-07-Dridex-infection-traffic.pcap](https://unit42.paloaltonetworks.com/wp-content/uploads/2020/10/word-image-24.jpeg)Figure 23. Traffic from the fifth pcap filtered in Wireshark using our basic web filter.

 

Checking through the domains, there is one non-Microsoft domain using HTTPS traffic that might be tied to the initial infection activity:

- newmg532.wordswideweb[.]com

Examine the post-infection Dridex C2 traffic. Use the following  filter in Wireshark to look at the certificate issuer data for HTTPS  traffic over the two IP addresses without domain names in the HTTPS  traffic:

tls.handshake.type eq 11 and (ip.addr eq 177.87.70.3 or ip.addr eq 188.250.8.142)

After applying the filter, select the first frame, go to the frame  details section and work your way to a list of lines that start with the term RDNSequence item as done in our first four examples.

The certificate issuer data follows the same pattern as our first  four examples. Check the issuer data for both IP addresses and find the  data listed below.

Certificate issuer data for Dridex HTTPS C2 traffic on 177.87.70[.]3:

- id-at-countryName=BS
- id-at-stateOrProvinceName=Sshopedts Inccofrew
- id-at-LocalityName=Nassau
- id-at-organizationName=Mesureder S.p.a.
- id-at-commonName=avothelyop.thedai9neasysb.author

Certificate issuer data for Dridex HTTPS C2 traffic on 188.250.8[.]142:

- id-at-countryName=UA
- id-at-stateOrProvinceName=avandi0
- id-at-LocalityName=Kiev
- id-at-organizationName=Icccodiso Icloneedb Oyj
- id-at-organizationalUnitName=4Zenyfea
- id-at-commonName=rebydustat.tci

These five examples should give a good idea of what certificate  issuer data for Dridex HTTPS C2 traffic looks like. These patterns  differ from many other malware families, but they are somewhat similar  to certificate issuer data from HTTPS C2 [Qakbot](https://unit42.paloaltonetworks.com/tutorial-qakbot-infection/) network traffic.

However, with Qakbot, the stateOrProvinceName is always a two-letter value, and the LocalityName consists of random characters.

With Dridex, the stateOrProvinceName consists of random characters, and the LocalityName is the capital city of whatever country is used for the countryName.

### Examining Emotet Infection Traffic

This tutorial is designed for security professionals who investigate  suspicious network activity and review packet captures (pcaps).  Familiarity with [Wireshark](https://www.wireshark.org/) is necessary to understand this tutorial, which focuses on Wireshark version 3.x.

[Emotet](https://malpedia.caad.fkie.fraunhofer.de/details/win.emotet) is an information-stealer [first reported in 2014](https://blog.trendmicro.com/trendlabs-security-intelligence/new-banking-malware-uses-network-sniffing-for-data-theft/) as banking malware. It has since evolved with additional functions such as a dropper, distributing other malware families like [Gootkit](https://isc.sans.edu/forums/diary/Emotet+infections+and+followup+malware/24532/), [IcedID](https://www.malware-traffic-analysis.net/2019/01/18/index.html), [Qakbot](https://www.malware-traffic-analysis.net/2020/08/10/index.html) and [Trickbot](https://twitter.com/Unit42_Intel/status/1320847745155059712).

Today’s Wireshark tutorial reviews recent Emotet activity and  provides some helpful tips on identifying this malware based on traffic  analysis.

Note: These instructions assume you have customized Wireshark as described in [our previous Wireshark tutorial about customizing the column display](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/).

You will need to access a GitHub repository with ZIP archives containing [the pcaps used for this tutorial](https://github.com/pan-unit42/wireshark-tutorial-Emotet-traffic).

**Warning:** Some of the pcaps used for this tutorial  contain Windows-based malware. There is a risk of infection if using a  Windows computer. If possible, we recommend you review these pcaps in a  non-Windows environment like BSD, Linux or macOS.

**Chain of Events for an Emotet Infection**

To understand network traffic caused by Emotet, you must first  understand the chain of events leading to an infection. Emotet is  commonly distributed through malicious spam (malspam) emails. The  critical step in an Emotet infection chain is a Microsoft Word document  with macros designed to infect a vulnerable Windows host.

![This Word document shown was used to cause an Emotet infection in January 2021. Note the message in the screenshot: This document is protected. Previewing is not available for protected documents. You have to press "ENABLE EDITING" and "ENABLE CONTENT" buttons to preview this document. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-30.jpeg)Figure 1. Screenshot of a Word document used to cause an Emotet infection in January 2021.

Malspam spreading Emotet uses different techniques to distribute these Word documents.

The malspam may contain an attached Microsoft Word document or have  an attached ZIP archive containing the Word document. In recent months,  we have seen several examples where these ZIP archives are  password-protected. Some emails distributing Emotet do not have any  attachments. Instead, they contain a link to download the Word document.

In previous years, malspam pushing Emotet has also used PDF  attachments with embedded links to deliver these Emotet Word documents.

Figure 2 illustrates these four distribution techniques.

![Distribution paths for Emotet Word document: 1) malspam with attachment to Word doc; 2) malspam with attachment to ZIP archive to Word doc; 3) malspam with link to web traffic to download Word doc to Word doc; 4) malspam with attachment to PDF file to web traffic to download Word doc to Word doc](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-31.jpeg)Figure 2. Various distribution paths for an Emotet Word document.

After the Word document is delivered, if a victim opens the document  and enables macros on a vulnerable Windows host, the host is infected  with Emotet.

From a traffic perspective, we see the following steps from an Emotet Word document to an Emotet infection:

- Web traffic to retrieve the initial binary.
- Encoded/encrypted command and control (C2) traffic over HTTP.
- Additional infection traffic if Emotet drops follow-up malware.
- SMTP traffic if Emotet uses the infected host as a spambot.

Figure 3 shows a flowchart of network activity we might find during an Emotet infection.

![Flowchart for an Emotet infection: Word doc to enable macros to web traffic for initial binary to initial binary. From there, encoded C2 traffic over HTTP, which is a hub in the flowchart that can lead to follow-up malware, spambot activity, data exfiltration and updating the binary. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-32.jpeg)Figure 3. Flowchart for an Emotet infection.

Since Dec. 21, 2020, the initial binary for Emotet has been a Windows DLL file. Previously, this binary had been a Windows EXE file.

Emotet C2 traffic consists of encoded or otherwise encrypted data  sent over HTTP. This C2 activity can use either standard or non-standard TCP ports associated with HTTP traffic. This C2 activity also consists  of data exfiltration and traffic to update the initial Emotet binary.

Since Emotet is also a malware dropper, the victim may become  infected with other malware. Analysts should search for traffic from  other malware when investigating traffic from an Emotet-infected host.

Finally, an Emotet-infected host may also become a spambot generating large amounts of traffic over TCP ports associated with SMTP like TCP  ports 25, 465 and 587.

**Pcaps of Emotet Infection Activity**

Five password-protected ZIP archives containing pcaps of recent Emotet infection traffic are available at [this GitHub repository](https://github.com/pan-unit42/wireshark-tutorial-Emotet-traffic). Once on the GitHub page, click on each of the ZIP archive entries and download them, as shown in Figures 4 and 5.

![The screenshot shows how to download ZIP archives used for this Wireshark tutorial from the GitHub repository. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-33.jpeg)Figure 4. GitHub repository with links to ZIP archives used for this tutorial.

![The screenshot shows where to click to download one of the ZIP archives used for this Wireshark Tutorial on analyzing Emotet infection traffic. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-34.jpeg)Figure 5. Downloading one of the ZIP archives for this tutorial.

Use ***infected\*** as the password to extract pcaps from these ZIP archives. This should give you the following five pcap files:

- Example-1-2021-01-06-Emotet-infection.pcap
- Example-2-2021-01-05-Emotet-with-spambot-traffic-part-1.pcap
- Example-3-2021-01-05-Emotet-with-spambot-traffic-part-2.pcap
- Example-4-2021-01-05-Emotet-infection-with-Trickbot.pcap
- Example-5-2020-08-18-Emotet-infection-with-Qakbot.pcap

**Example 1: Emotet Infection Traffic**

Open ***Example-1-2021-01-06-Emotet-infection.pcap\*** in Wireshark and use a basic web filter as described in our previous[ tutorial about Wireshark filters](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/). The basic filter for Wireshark 3.x is:

(http.request or tls.handshake.type eq 1) and !(ssdp)

If you’ve set up Wireshark according to our initial [tutorial about customizing Wireshark displays](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/), your display should look similar to Figure 6.

![Figure 6. Our first pcap in this tutorial filtered in Wireshark.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-35.jpeg)Figure 6. Our first pcap in this tutorial filtered in Wireshark.

As shown in Figure 6, the first five HTTP GET requests represent four URLs used to retrieve the initial Emotet DLL. The traffic is:

- hangarlastik[.]com GET /cgi-bin/Ui4n/
- hangarlastik[.]com GET /cgi-sys/suspendedpage.cgi
- padreescapes[.]com GET /blog/0I/
- sarture[.]com GET /wp-includes/JD8/
- seo.udaipurkart[.]com GET /rx-5700-6hnr7/Sgms/

The first two URLs indicate hangarlastik[.]com no longer had the Emotet DLL file it had been hosting. Follow TCP  streams for each of these requests to see replies to each of the HTTP  GET requests.

An easier way to see the HTTP responses is to update your Wireshark basic web filter to include HTTP responses:

(http.request **or http.response** or tls.handshake.type eq 1) and !(ssdp)

This will show HTTP responses in the ***Info\*** column, as illustrated in Figure 7.

![Figure 7. Adding HTTP responses to the Wireshark display filter.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-36.jpeg)Figure 7. Adding HTTP responses to the Wireshark display filter.

Now we have a clearer picture of what happened when the Word macro tried to retrieve an Emotet DLL:

- hangarlastik[.]com GET /cgi-bin/Ui4n/
- HTTP/1.1 302 Found
- hangarlastik[.]com GET /cgi-sys/suspendedpage.cgi
- HTTP/1.1 200 OK
- padreescapes[.]com GET /blog/0I/
- HTTP/1.1 401 Unauthorized
- sarture[.]com GET /wp-includes/JD8/
- HTTP/1.1 403 Forbidden
- seo.udaipurkart[.]com GET /rx-5700-6hnr7/Sgms/

The only 200 OK was a reply for a suspended page notification from hangarlastik[.]com.

The HTTP GET request to seo.udaipurkart[.]com does not show a response, so follow the TCP stream for this request, as shown in Figure 8.



![Figure 8. Following TCP stream for the HTTP request to seo.udaipurkart[.]com.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-37.jpeg)Figure 8. Following TCP stream for the HTTP request to seo.udaipurkart[.]com.


 The TCP stream shows indicators that seo.udaipurkart[.]com returned a Windows DLL file, as shown in Figure 9.





![Figure 9. Indicators of a DLL file returned from seo.udaipurkart[.]com.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-38.jpeg)Figure 9. Indicators of a DLL file returned from seo.udaipurkart[.]com.

Export this DLL from the pcap by using the menu path: ***File --> Export Objects --> HTTP,\*** as shown in Figure 10. As always, we recommend you do not export this  file in a Windows environment, since the DLL is Windows-based malware.



![Figure 10. Exporting the Emotet DLL from our first pcap.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-39.jpeg)Figure 10. Exporting the Emotet DLL from our first pcap.

The SHA256 hash for this extracted DLL is:

8e37a82ff94c03a5be3f9dd76b9dfc335a0f70efc0d8fd3dca9ca34dd287de1b

Emotet C2 traffic is encoded data sent using HTTP POST requests. You  can easily find these requests in Wireshark using the following filter:

http.request.method eq POST

The results are shown in Figure 11.

![Figure 11. Filtering for HTTP POST requests in our first pcap.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-40.jpeg)Figure 11. Filtering for HTTP POST requests in our first pcap.

In our first pcap, Emotet C2 traffic consists of HTTP POST requests to:

- 5.2.136[.]90 over TCP port 80
- 167.71.4[.]0 over TCP port 8080

Emotet generates two types of HTTP POST requests for its C2 traffic. The first type of POST request ends with HTTP/1.1. The second type of POST request ends with HTTP/1.1 (application/x-www-form-urlencoded).

Follow the TCP stream for the initial HTTP request to 5.2.136[.]90 at 16:42:34 UTC to see an example of the first type of C2 POST request, as shown in Figure 12.

![Figure 12. The first type of HTTP POST request for Emotet C2 traffic.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-41.jpeg)Figure 12. The first type of HTTP POST request for Emotet C2 traffic.

Figure 12 shows this POST request sends approximately 6 KB of  form-data that appears to be an encoded or encrypted binary. Scroll down to the HTTP response to see encoded data returned from the server.  Figure 13 shows the start of this encoded data.

![Figure 13. Encoded data returned from the server in response to the HTTP POST request.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-42.jpeg)Figure 13. Encoded data returned from the server in response to the HTTP POST request.

This type of encoded or encrypted data is how Emotet botnet servers  exchange data with an infected Windows host. This is also the channel  Emotet uses to update the Emotet DLL and drop follow-up malware.

The second type of HTTP POST request for Emotet C2 traffic looks  noticeably different than the first type. Use the following filter in  Wireshark to easily find the second type of HTTP POST request:

urlencoded-form

This should return two HTTP POST requests to 167.71.4[.]0 over TCP port 8080, as shown in Figure 14.

![Figure 14. Filtering for the second type of HTTP POST request in Emotet C2 traffic.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-43.jpeg)Figure 14. Filtering for the second type of HTTP POST request in Emotet C2 traffic.

Follow the TCP stream for the first of these two HTTP POST requests  at 16:58:43 UTC. Review the traffic. The results are shown in Figure 15.

![Figure 15. TCP stream for the second type of HTTP POST request in Emotet C2 traffic.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-44.jpeg)Figure 15. TCP stream for the second type of HTTP POST request in Emotet C2 traffic.

As shown in Figure 15, some of the data sent in the POST request is  encoded as a base64 string with some URL encoding. For example, %2B is used for a + symbol, %2F represents / and %3D is used for =.

Data sent in response from the server is encoded or otherwise encrypted.

Our first pcap has no follow-up malware or other significant activity.

The only other activity is repeated connection attempts to 46.101.230[.]194 over TCP port 443. You can easily spot this activity by filtering on TCP SYN segments that are retransmissions. Use the following Wireshark filter:

tcp.analysis.retransmission and tcp.flags eq 0x0002

The results are shown in Figure 16.

![Figure 16. Filtering on retransmissions of TCP SYN segments in Wireshark.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-45.jpeg)Figure 16. Filtering on retransmissions of TCP SYN segments in Wireshark.

An Internet search on 46.101.230[.]194 should reveal this IP address has been used for Emotet C2 activity.

The remaining traffic in the pcap is system traffic generated by a Microsoft Windows 10 host.

In our next pcap, we examine an Emotet infection with spambot activity.

**Example 2: Emotet With Spambot Traffic, Part 1**

Open ***Example-2-2021-01-05-Emotet-with-spambot-traffic-part-1.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 17.

![Figure 17. Traffic from the second pcap filtered in Wireshark using our basic web filter.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-46.jpeg)Figure 17. Traffic from the second pcap filtered in Wireshark using our basic web filter.

Similar to our first example, we receive some HTTP GET requests  before Emotet C2 traffic. These GET requests are attempts to download  the initial Emotet DLL over web traffic. The first frame in the column  display shows HTTPS traffic to obob[.]tv, which was probably a web request for the initial Emotet DLL, because [this domain was reported as hosting an Emotet binary on Jan. 5, 2021](https://urlhaus.abuse.ch/url/949290/), the same date as the traffic in our pcap.

Follow the TCP stream for the HTTP GET request to miprimercamino[.]com to confirm it returned an Emotet DLL. You should see indicators similar to Figure 9 from our first pcap. We can export the Emotet DLL returned  from miprimercamino[.]com, as shown in Figure 18.

![Figure 18. Exporting the Emotet DLL from the pcap.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-47.jpeg)Figure 18. Exporting the Emotet DLL from the pcap.

The SHA256 hash for the extracted DLL from our second pcap is:

963b00584d8d63ea84585f7457e6ddcac9eda54428a432f388a1ffee21137316

Again, we find two types of HTTP POST requests for Emotet C2 traffic. To filter for each type of Emotet C2 HTTP POST request, use the  following Wireshark filters:

- First type: http.request method eq POST and !(urlencoded-form)
- Second type: urlencoded-form

Follow TCP streams for the HTTP POST requests returned by these  filters and confirm they follow the same patterns seen in our first  pcap.

After reviewing some examples of Emotet C2 traffic from this pcap, let’s move on to the spambot activity.

In this example, our infected host was turned into a spambot, so we  also have SMTP traffic. The spambot SMTP traffic is encrypted, but we  can easily find it by using our basic web filter and scrolling down the  column display.

At 20:06:20 UTC, the pcap starts showing SSL/TLS traffic to TCP ports associated with the SMTP email protocol, like TCP ports 25, 465 and  587, as shown in Figure 19.

![Figure 19. Using the basic web filter and scrolling through the column display to find spambot traffic.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-48.jpeg)Figure 19. Using the basic web filter and scrolling through the column display to find spambot traffic.

We can filter on smtp to find some of the SMTP commands before encrypted SMTP tunnels are established. Figure 20 shows the results.

![Figure 20. Filtering for SMTP traffic in our second pcap.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-49.jpeg)Figure 20. Filtering for SMTP traffic in our second pcap.

We can sometimes find unencrypted SMTP from spambot traffic generated by an Emotet-infected Windows host. Unencrypted SMTP will reveal its  message content, but the volume of encrypted SMTP from a spambot host is far greater than the volume of unencrypted SMTP. Therefore, most of the spambot messages from an Emotet-infected host are hidden within the  encrypted traffic.

In this example, you should only see encrypted SMTP traffic.

But our next example is later from this same infection, when we finally saw some unencrypted SMTP.

**Example 3: Emotet With Spambot Traffic, Part 2**

Open ***Example-3-2021-01-05-Emotet-with-spambot-traffic-part-2.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 21.

![Figure 21. Traffic from the third pcap filtered in Wireshark using our basic web filter.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-50.jpeg)Figure 21. Traffic from the third pcap filtered in Wireshark using our basic web filter.

In this pcap, we still see HTTP POST requests for Emotet C2 traffic,  at least twice each minute. We can also find encrypted spambot activity  similar to our previous pcap.

Spambot activity frequently generates a large amount of traffic. This pcap consists of 4 minutes and 42 seconds of spambot activity from the  infected Windows host, and it’s over 21 MB of traffic.

We can quickly identify any unencrypted SMTP traffic by using the following Wireshark filter:

smtp.data.fragment

Figure 22 shows the results of this filter for our third pcap. The  filter reveals five examples of Emotet malspam generated by the infected Windows host.

![Figure 22. Filtering for indicators of unencrypted SMTP from spambot traffic.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-51.jpeg)Figure 22. Filtering for indicators of unencrypted SMTP from spambot traffic.

Follow the TCP stream for the last email from: "Gladisbel Miranda at 20:19:54 UTC. Examine what these messages look like, as shown in Figure 23.

![Figure 23. TCP stream for an example of Emotet malspam from our third pcap.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-52.jpeg)Figure 23. TCP stream for an example of Emotet malspam from our third pcap.

We can export these five items of Emotet malspam by using the menu path ***File --> Export Objects --> IMF,\*** as shown in Figure 24.

![Figure 24. Exporting Emotet malspam from our third pcap.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-53.jpeg)Figure 24. Exporting Emotet malspam from our third pcap.

Export these emails and examine them. Ideally, we recommend doing this in a non-Windows environment. [Thunderbird](https://www.thunderbird.net/en-US/) is a free email client you can use to see how a potential victim might view these emails.

As mentioned earlier, Emotet is also a malware downloader. Perhaps  the most common malware distributed through Emotet is Trickbot.

**Example 4: Emotet Infection with Trickbot**

Open ***Example-4-2021-01-05-Emotet-infection-with-Trickbot.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 25.

![Figure 25. Traffic from the fourth pcap filtered in Wireshark using our basic web filter.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-54.jpeg)Figure 25. Traffic from the fourth pcap filtered in Wireshark using our basic web filter.

This pcap does not have an HTTP GET request for an initial Emotet  DLL. However, the first frame in our column display shows HTTPS traffic  to fathekarim[.]com. This was probably a web request for the Emotet DLL, because [this domain was reported as hosting an Emotet binary on Jan. 5, 2021](https://urlhaus.abuse.ch/url/949449/), the same date as the traffic in our pcap.

You should find the same two types of HTTP POST requests associated with Emotet C2, as described in our previous two pcaps.

This pcap also contains indicators of a Trickbot infection. Use your  basic web filter and scroll down to find Trickbot traffic, as shown in  Figure 26.

![Figure 26. Scrolling down the column display to find Trickbot indicators in our fourth pcap using a basic web filter.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-55.jpeg)Figure 26. Scrolling down the column display to find Trickbot indicators in our fourth pcap using a basic web filter.

We’ve reviewed Trickbot in [our previous Wireshark tutorial on examining Trickbot infections](https://unit42.paloaltonetworks.com/wireshark-tutorial-examining-trickbot-infections/), but here is a quick refresher. The following are common indicators for Trickbot:

- HTTPS traffic over TCP ports 447 or 449 without an associated domain or hostname.
- HTTP POST requests over standard or non-standard TCP ports for HTTP traffic that end with /81/, /83/ or /90, which are associated with data exfiltration.
- With Trickbot from Emotet infections, the above HTTP POST requests start with /mor followed by a number (only one or two digits seen so far).
- HTTP GET requests for URLs that end in .png that return additional Trickbot binaries.

We can easily find these indicators using the following Wireshark filters:

- tls.handshake.type eq 1 and (tcp.port eq 447 or tcp.port eq 449)
- (http.request.uri contains /81 or http.request.uri contains /83 or http.request.uri  contains /90) and http.request.uri contains mor
- http.request.uri contains .png

Figures 27-29 show the results from each of the above filters.

![Figure 27.: Filtering for Trickbot HTTPS traffic over TCP port 447 or TCP port 449.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-56.jpeg)Figure 27.: Filtering for Trickbot HTTPS traffic over TCP port 447 or TCP port 449.

![Figure 28. Filtering for HTTP POST requests associated with Trickbot data exfiltration.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-57.jpeg)Figure 28. Filtering for HTTP POST requests associated with Trickbot data exfiltration.

Follow TCP streams for each of the HTTP POST requests shown in Figure 28 to see if any password data was exfiltrated. The last HTTP POST  request ending with /90 contains data about the infected Windows host and its environment.

![Figure 29. Filtering for HTTP GET requests ending in .png associated with additional Trickbot binaries.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-58.jpeg)Figure 29. Filtering for HTTP GET requests ending in .png associated with additional Trickbot binaries.

Follow TCP streams for each of the HTTP POST requests shown in Figure 29 to see if any Windows binaries were returned. Doing so should reveal two Windows executable files. You can then export these binaries from  the pcap using ***File --> Export Objects --> HTTP,\*** as discussed in our previous examples.

SHA256 hashes for these two Windows binaries (both EXE files) are:

- 59e1711d6e4323da2dc22cdee30ba8876def991f6e476f29a0d3f983368ab461 for mingup.png
- ed8dea5381a7f6c78108a04344dc73d5669690b7ecfe6e44b2c61687a2306785 for saved.png

Trickbot is the most common malware distributed by Emotet, but it is  not the only one. Qakbot is another type of malware frequently dropped  on Emotet-infected Windows hosts.

**Example 5: Emotet Infection With Qakbot**

Open ***Example-5-2020-08-18-Emotet-infection-with-Qakbot.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 30.

![Figure 30. Traffic from the fifth pcap filtered in Wireshark using our basic web filter.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-59.jpeg)Figure 30. Traffic from the fifth pcap filtered in Wireshark using our basic web filter.

In our fifth pcap, an Emotet Word document was retrieved from saketpranamam.mysquare[.]in at 21:23:50 UTC, which matches [a URL reported as hosting an Emotet Word document on the same date](https://urlhaus.abuse.ch/url/435882/). Export this Word document from the pcap using ***File --> Export Objects --> HTTP,\*** as discussed in our previous examples.

The SHA256 hash for this extracted Word document is:

- c7f429dde8986a1b2fc51a9b3f4a78a92311677a01790682120ab603fd3c2fcb

We also see HTTPS traffic to samaritantec[.]com at 21:24:40 UTC. [This domain was reported as hosting an Emotet binary on the same date](https://urlhaus.abuse.ch/url/436011/).

As in our previous examples, you should find the same two types of HTTP POST requests associated with Emotet C2 traffic.

Additionally, this pcap contains indicators of a Qakbot infection.  Use your basic web filter and scroll down to find Qakbot traffic, as  shown in Figure 31.

![Figure 31. Scrolling down the column display to find Qakbot indicators in our fifth pcap using a basic web filter.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-60.jpeg)Figure 31. Scrolling down the column display to find Qakbot indicators in our fifth pcap using a basic web filter.

We’ve reviewed Qakbot in [our previous Wireshark tutorial on examining Qakbot infections](https://unit42.paloaltonetworks.com/tutorial-qakbot-infection/), but here is a quick refresher. The following are common indicators for Qakbot:

- HTTPS traffic over standard and non-standard TCP ports for HTTPS.
- Certificate data for Qakbot HTTPS traffic has unusual values for the issuer fields, and the certificate is not issued by an authority based  in the United States.
- TCP traffic over TCP port 65400.
- Prior to late November 2020, Qakbot commonly generated HTTPS traffic to cdn.speedof[.]me.
- Prior to late November 2020, Qakbot commonly generated HTTP GET requests to a.strandsglobal[.]com.

We can easily find these indicators by using the following Wireshark filters:

- tls.handshake.type eq 11 and !(x509sat.CountryName == US)
- tcp.port eq 65400
- tls.handshake.extensions_server_name contains speedof
- http.host contains strandsglobal

Figures 32-35 show the results from each of the above filters.

![Figure 32. Filtering and searching for unusual certificate issuer data in HTTPS traffic generated by Qakbot.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-61.jpeg)Figure 32. Filtering and searching for unusual certificate issuer data in HTTPS traffic generated by Qakbot.

In Figure 32, the results of our first filter show several frames in the column display for traffic from 71.80.66[.]107. Search through the frame details and find unusual certificate issuer data, as shown above.

![Figure 33. Filtering for Qakbot traffic over TCP port 65400.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-62.jpeg)Figure 33. Filtering for Qakbot traffic over TCP port 65400.

In the above image, we find a single TCP stream of Qakbot traffic  over TCP port 65400. This stream contains the public IP address and a  botnet identification string for the Qakbot-infected Windows host.



![Figure 34. Filtering for traffic to cdn.speedof[.]me, which is not inherently malicious, but a connectivity check caused by Qakbot prior to late November 2020.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-63.jpeg)Figure 34. Filtering for traffic to cdn.speedof[.]me, which is not inherently  malicious, but a connectivity check caused by Qakbot prior to late  November 2020.

![Figure 35. Filtering for traffic to a.stransglobal[.]com, typically generated by Qakbot prior to late November 2020.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/01/word-image-64.jpeg)Figure 35. Filtering for traffic to a.stransglobal[.]com, typically generated by Qakbot prior to late November 2020.

While Emotet has commonly dropped Trickbot and Qakbot, be aware that Emotet  has also dropped other types of malware such as Gootkit and IcedID.

### Decrypting RDP Traffic

In recent years, Remote Desktop Protocol (RDP) has been exploited by  attackers to access unsecured servers and enterprise networks. Since  2017, RDP has become a significant vector in malware attacks using  ransomware. Security professionals have increasingly focused their  attention on this protocol by writing signatures to detect RDP  vulnerabilities and prevent attacks.

As a proprietary protocol from Microsoft, RDP supports several  operating modes that encrypt network traffic. Unfortunately, this  encryption makes writing RDP signatures difficult because RDP content is hidden.

Fortunately, we can establish a test environment that provides a key  file, and we can use that key to decrypt a packet capture (pcap) of the  RDP traffic in Wireshark.

This blog demonstrates how to prepare the environment, obtain a decryption key and use it to decrypt RDP traffic.

**Requirements**

The following are necessary to get the most value from this tutorial:

- A virtual environment to run two Windows hosts like VirtualBox or VMware.
- An understanding of how to set up and use RDP.
- An RDP client. We use a host running Windows 10 Professional for this tutorial.
- An RDP server. This can be another Windows host with RDP enabled, or it can be a non-Windows host running FreeRDP.
- A way to record the network traffic between these two hosts. This is most easily done within a virtual environment.
- Wireshark version 3.0 or better.
- A basic knowledge of network traffic fundamentals.

**Overall Process**

The overall process follows seven general steps:

Step 1: Set up a virtual environment with two hosts, one acting as an RDP client and one acting as an RDP server.

Step 2: Remove forward secrecy ciphers from the RDP client.

Step 3: Obtain the RDP server's private encryption key.

Step 4: Capture RDP traffic between the RDP server and Windows client.

Step 5: Open the pcap in Wireshark.

Step 6: Load the key in Wireshark.

Step 7: Examine RDP data.

#### Step 1: Set Up Virtual Environment

The two most common virtual environments for this type of analysis are [VirtualBox](https://www.virtualbox.org/) or VMware Workstation for Windows and Linux. VMWare Fusion is used for  macOS. VirtualBox is free, while VMware is a commercial product.

This tutorial does not cover setting up virtual machines (VMs) in a  virtual environment. The basic structure of our lab used for this  tutorial is shown below in Figure 1.

![The lab setup used for this tutorial on decrypting RDP traffic includes a physical host running a virtualization environment, a virtual LAN, a Windows VM acting as an RDP client and a Windows VM acting as an RDP server. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-122.png)Figure 1. Lab setup used for this tutorial.

Our lab environment contained two Windows 10 hosts. One of the hosts  acted as an RDP client, and the other acted as an RDP server. We  recorded network traffic from an RDP session between these two hosts  from the virtual LAN.

#### Step 2: Remove Forward Secrecy Ciphers From RDP Client

Some encryption ciphers provide [forward secrecy](https://www.keycdn.com/blog/perfect-forward-secrecy), which is also known as perfect forward secrecy. These types of ciphers  create multiple session keys for an SSL/TLS connection. With forward  secrecy, we cannot decrypt SSL/TLS traffic using a single private  encryption key from the RDP server. Therefore, we had to remove  configuration options that support forward secrecy on the RDP client.

For this tutorial, our RDP client was a host running Windows 10 Pro. This host has a built-in RDP client.

Microsoft has published details on removing configuration options that support forward secrecy in the articles, “[Manage Transport Layer Security (TLS)](https://docs.microsoft.com/en-us/windows-server/security/tls/manage-tls)” and “[Prioritizing Schannel Cipher Suites](https://docs.microsoft.com/en-us/windows/win32/secauthn/prioritizing-schannel-cipher-suites).” Below is a step-by-step process that we used.

Open the Group Policy Management Console ***gpedit.msc\*** as an administrator as shown below in Figure 2.

![Open the Group Policy Management Console gpedit.msc as an administrator by clicking "Run as administrator," as shown here. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-123.png)Figure 2. Running the Group Policy Editor in Windows 10 Pro as an administrator.

From the console, use the following menu path:

- Computer Configuration.
- Administrative Templates.
- Network.
- SSL Configuration Settings.

Below, Figure 3 shows how to find SSL Configuration Settings.

![The large black arrow in the screenshot indicates the location of the SSL Configuration Settings in the file system. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-124.png)Figure 3. Getting to the SSL Configuration Settings.

Under SSL Configuration Settings, double-click the entry for ***SSL Cipher Suite Order\*** as shown below in Figure 4.

![Figure 4. Getting to the SSL Cipher Suite Order.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-125.png)Figure 4. Getting to the SSL Cipher Suite Order.

Under the SSL Cipher Suite Order, click the ***Enabled\*** option as shown below in Figure 5.

![The large black arrow indicates where to click to enable SSL Cipher Suite Order. An explanation in the screenshot states, "This policy setting determines the cipher suites used by the Secure Socket Layer. If you enable this policy setting, SSL cipher suites are prioritized in the order specifiied." ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-126.png)Figure 5. Enabling the SSL Cipher Suite Order.

Next, double-click the list of ciphers and select the entire list as shown below in Figure 6.

![The next step is to select the entire list of ciphers as shown in the screenshot. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-127.png)Figure 6. Selecting the list of ciphers.

Once the list has been selected, copy it as shown below in Figure 7.

![Copy the list of ciphers as shown. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-128.png)Figure 7. Copying the list of ciphers.

Copy this list of ciphers into a text editor such as Notepad. Remove  any ciphers that support Elliptic Curve cryptography using  Diffie-Hellman Ephemeral (ECDHE) or Digital Signature Algorithm (ECDSA)  encryption. These should be any entries with ECDHE and/or ECDSA in the  name. In the example shown below in Figure 8, these ciphers were all  located sequentially, so they were easy to delete from the text.

![Delete ciphers that support Elliptic Curve cryptography by removing any entries with ECDHE and/or ECDHA in the name. In our example, the ciphers were located sequentially and were therefore easy to delete. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-129.png)Figure 8. Deleting entries for ECDHE and ECDSA.

Our updated list of ciphers from Figure 8 is listed below in Table 1.

TLS_AES_256_GCM_SHA384,TLS_AES_128_GCM_SHA256,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_3DES_EDE_CBC_SHA,TLS_RSA_WITH_NULL_SHA256,TLS_RSA_WITH_NULL_SHA,TLS_PSK_WITH_AES_256_GCM_SHA384,TLS_PSK_WITH_AES_128_GCM_SHA256,TLS_PSK_WITH_AES_256_CBC_SHA384,TLS_PSK_WITH_AES_128_CBC_SHA256,TLS_PSK_WITH_NULL_SHA384,TLS_PSK_WITH_NULL_SHA256

*Table 1. Updated list after removing forward secrecy ciphers.*

Paste the updated cipher list back into the SSL Cipher Suites Field,  making sure to overwrite the original list. Click the Apply button, then click OK to close the window. You have now updated the list and can  close the Group Policy Editor.

After we accomplished this step, we had to obtain the RDP server’s private key.

#### Step 3: Obtain RDP Server's Private Key

FreeRDP is one option to use as an RDP server. You can get FreeRDP from [this GitHub repository](https://github.com/FreeRDP), as well as [build instructions](https://github.com/FreeRDP/FreeRDP/wiki/Compilation). Make sure to set the ***WITH_SERVER=ON\*** flag when creating the server. Once the server is built, you must  provide it with a private key, or use one that comes with FreeRDP.

For our RDP server in this tutorial, we used another host running  Windows 10 Pro. Then we extracted the private key from the host’s  operating system.

To ensure our second Windows host acted as an RDP server, we enabled  RDP. To enable RDP on a host running Windows 10 Pro, go to Windows  Settings from the Start Menu, then select the ***System\*** icon as shown below in Figure 9.

![To ensure our second Windows host acted as an RDP server, we enabled RDP by selecting the System icon as shown here. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-130.png)Figure 9. Getting to the Windows System settings.

Under the system settings, select ***Remote Desktop\*** and click the switch for ***Enable Remote Desktop\*** as shown below in Figure 10.

![The large black arrows show where to select Remote Desktop and where to click the switch for Enable Remote Desktop. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-131.png)Figure 10. Enabling RDP in WIndows 10.

After setting up our second Windows host as an RDP server, we extracted the private key from its operating system.

To extract the server key, we could either use either Jailbreak or [Mimikatz](https://www.varonis.com/blog/what-is-mimikatz/). We chose Jailbreak.

[Jailbreak](https://github.com/iSECPartners/jailbreak) is a tool by iSECPartners that can export the server's RDP certificate. From the exported certificate, we could extract the private key.

To use Jailbreak, we downloaded the following Jailbreak binaires from [this GitHub repository](https://github.com/iSECPartners/jailbreak/tree/master/binaries) on our newly established RDP server:

- EasyHook64.dll
- jailbreak64.exe
- jailbreakhook64.dll
- jbstore2_64.exe

Note: The above files were used on a Windows 10 Pro 64-bit host  downloaded on March 4, 2021. A screenshot of the GitHub page is shown  below in Figure 11.

![A screenshot of the Jailbreak GitHub page taken on March 4 shows the Jailbreak binaries we downloaded. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-132.png)Figure 11. GitHub page for Jailbreak binaries.

After we downloaded the Jailbreak binaries, we opened a Command  prompt with administrator privileges as shown below in Figure 12.

![The large black arrow indicates how to open a Command prompt with administrator privileges. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-133.png)Figure 12. Opening a command prompt as an administrator.

In the command prompt, we went to the directory with the downloaded  Jailbreak binaries. We ran the following command from this directory:

- jailbreak64.exe %WINDIR%\system32\mmc.exe %WINDIR%\system32\certlm.msc -64

If we were running a 32-bit version of Windows, we would use:

- jailbreak32.exe %WINDIR%\system32\mmc.exe %WINDIR%\system32\certlm.msc -32

See Figure 13 below for an example of running the 64-bit command on our Windows host acting as the RDP server.

![The screenshot shows an example of running the 64-bit command on our Windows host acting as the RDP server. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-134.png)Figure 13. Running Jailbreak from the command prompt.

This command opened the certificate manager for our local machine. From the left column, we expanded ***Remote Desktop\*** and went to the ***Certificates\*** folder. This showed one certificate. If there had been more than one  certificate, we would have selected the one with the most recent  expiration date. We right-clicked on the certificate, selected ***All Tasks\*** then used ***Export\*** as shown below in Figure 14.

![We right-clicked on the certificate, selected All Tasks then used Export as shown.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-135.png)Figure 14. Exporting the RDP certificate.

When exporting the certificate, we made sure to select the option to export the private key as shown below in Figure 15.

![The screenshot reads: "Export Private Key: You can choose to export the private key with the certificate. Private keys are password protected. If you want to export the private key with the certificate, you must type a password on a later page. Do you want to export the private key with the certificate?" The large black arrow shows what to select to ensure the private key is exported with the certificate. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-136.png)Figure 15. Ensuring the private key is exported with the certificate.

For our host, we could only export the certificate as a PKCS #12 (.PFX) file as shown below in Figure 16.

![For the host used in this tutorial on decrypting RDP traffic in Wireshark, we could only export the certificate as a PKCS #12 (.PFX) file, as shown. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-137.png)Figure 16. Could only export the certificate as a .pfx file.

As shown below in Figure 17, the certificate had to have a password.  Fortunately, we had no complexity requirements, so we used a single  letter as the password.

![As shown, the certificate had to have a password. Because we had not complexity requirements, we used a single letter as the password. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-138.png)Figure 17. The export process required a password for the certificate.

Finally, we exported our certificate with the private key as shown below in Figure 18.

![We exported our certificate with the private key as shown. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-139.png)Figure 18. Completing our certificate export.

As an alternative, we could have extracted the server’s certificate  using Mimikatz instead of Jailbreak. The instructions for using Mimikatz to get the RDP server certificate are listed on [GitHub](https://github.com/FreeRDP/FreeRDP/wiki/Mimikatz).

Since our certificate was obtained using Jailbreak, we moved it to a  Linux host and used OpenSSL to extract the key. First, we used the  following OpenSSL command to extract the key in PEM format:

- openssl pkcs12 -in server_certificate.pfx -nocerts -out server_key.pem -nodes

To remove the passphrase form the key, we also used the following command:

- openssl rsa -in server_key.pem -out server.key

This provided us with the RDP server’s private key as shown below in Figure 19.

![The black arrow and label "private key" indicate where the private server key was extracted from the certificate. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-140.png)Figure 19. Private server key extracted from the certificate.

Before we could use the private server key, we needed to record an  RDP session between our two Windows hosts and save it as a pcap.

#### Step 4: Capture RDP Traffic

With our two Windows hosts in the same virtual environment, we could use a tool like [dumpcap](https://www.wireshark.org/docs/man-pages/dumpcap.html), [tcpdump](https://www.tcpdump.org/) or Wireshark itself to record network traffic in the VLAN using  promiscuous mode. Once the recording started, our WIndows client used  RDP to log in to the other Windows host acting as an RDP server. The  host name of the server was ***DESKTOP-USER1PC\***.

![The screenshot shows how our Windows client used RDP to log in to the other Windows host acting as an RDP server. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-141.png)Figure 20. Using the Remote Desktop Connection tool to log into our RDP server.

While the pcap was being recorded, we logged into ***DESKTOP-USER1PC\*** and performed some basic tasks like opening documents and web browsing.

![While the pcap was being recorded, we logged in to DESKTOP-USER1PC and performed some basic tasks, such as opening documents and web browsing. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-142.png)Figure 21. Performing some common desktop tasks through RDP.

After a minute or so, we logged off RDP and stopped recording network traffic from our VLAN.

#### Step 5: Open the pcap in Wireshark

We opened the pcap of our RDP session in Wireshark. When filtering on ***rdp\*** in our Wireshark display filter, we saw no results because the RDP  traffic was encrypted. Figure 22 shows the blank column display we saw  when filtering for RDP in our pcap.

![Because RDP traffic was encrypted, we see a blank column display, as shown, when filtering for RDP in our pcap. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-143.png)Figure 22. Filtering for RDP information, but no results, due to encrypted RDP traffic.

However, when we used our private server key to decrypt RDP traffic in Wireshark, the results looked much different.

#### Step 6: Load the Key in Wireshark

In the pcaps we recorded, the RDP server ***DESKTOP-USER1PC\*** was at IP address ***10.3.4.138\***, and RDP traffic took place over TCP port 3389. We needed this information to properly decrypt RDP traffic in Wireshark.

In Wireshark, we used the Preferences window and expanded the ***Protocols\*** section as shown below in Figure 23.

![For decrypting RDP traffic in Wireshark, we need IP address and port information. In Wireshark, we used the Preferences window and expanded the Protocols section as shown. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-144.png)Figure 23. Getting to the Protocols section of Wireshark’s preferences menu.

With Wireshark 3.x, use the ***TLS\*** entry. If you are using Wireshark 2.x, use the ***SSL\*** entry. For this section, there should be a button to edit the ***RSA keys list\***. We clicked the button and added the IP address of the RDP server, the  RDP port (3389) and the location of the private key file. Our example is shown below in Figure 24.

![We clicked the button and added the IP address of the RDP server, the RDP port (3389) and the location of the private key file.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-145.png)Figure 24. Go to the TLS section and add the private key to the RSA keys list.

After Wireshark was set up to decrypt RDP traffic, we had much better results when reviewing the pcap.

#### Step 7: Examine RDP Data

After our key was loaded, our column display was no longer blank when filtering for RDP. We had several results as shown below in Figure 25.

![After our key was loaded, decrypting RDP traffic became possible. The screenshot shows that our column display was no longer blank when filtering for RDP. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/03/word-image-146.png)Figure 25. Viewing the same RDP activity after the private key was loaded in Wireshark.

For security professionals who write signatures to find RDP  vulnerabilities and attacks, the type of information revealed above in  Figure 25 is critical to their work.

### Examining Traffic from Hancitor Infections

Also known as Chanitor, [Hancitor](https://malpedia.caad.fkie.fraunhofer.de/details/win.hancitor) is malware used by a threat actor designated as MAN1, Moskalvzapoe or  TA511. Hancitor establishes initial access on a vulnerable Windows host  and sends additional malware. This Wireshark tutorial reviews activity  from recent Hancitor infections. It provides tips on identifying  Hancitor and its followup malware. In this tutorial, we cover examples  of Hancitor with [Cobalt Strike](https://attack.mitre.org/software/S0154/), [Ficker Stealer](https://twitter.com/3xp0rtblog/status/1321209656774135810), [NetSupport Manager RAT](https://www.bleepingcomputer.com/news/security/microsoft-warns-of-massive-phishing-attack-pushing-legit-rat/), a [network ping tool](https://unit42.paloaltonetworks.com/hancitor-infections-cobalt-strike/) and [Send-Safe](http://web.archive.org/web/20190918103313/www.send-safe.com/send-safe.html) spambot malware.

This tutorial is designed for security professionals who investigate  suspicious network activity and review packet captures (pcaps).  Familiarity with [Wireshark](https://www.wireshark.org/) is necessary to understand this tutorial, which focuses on Wireshark version 3.x.

Note: These instructions assume you have customized Wireshark as described in [our previous Wireshark tutorial about customizing the column display](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/).

You will need to access a GitHub repository with ZIP archives containing [the pcaps used for this tutorial](https://github.com/pan-unit42/wireshark-tutorial-Hancitor-traffic).

**Warning:** The pcaps for this tutorial contain  Windows-based malware. There is a risk of infection if using a Windows  computer. If possible, we recommend you review these pcaps in a  non-Windows environment such as BSD, Linux or macOS.

**Chain of Events for a Hancitor Infection**

Hancitor is distributed through email. These emails each contain an HTTPS link for a Google Drive URL through docs.google.com. These Google Drive pages link to a different domain that returns a  malicious Word document. Enabling macros on the Word document starts the infection by dropping a DLL.

The infected host first generates Hancitor command and control (C2)  traffic. Then we see URLs for followup malware such as Ficker Stealer.  If the infected host is part of an Active Directory (AD) environment,  Hancitor will also send Cobalt Strike. Cobalt Strike provides another  access channel for further malicious files such as a network ping tool  or NetSupport Manager RAT-based malware. In some cases, we also see  Send-Safe spambot malware, which turns the infected Windows host into a  spambot pushing more Hancitor emails.

![The chain of events for recent Hancitor infections includes malspam with a Google Docs link, a Google Docs page, a page to download a Word doc, a downloaded Word doc, enabling macros, Hancitor malware, Hancitor C2 traffic, Ficker Stealer and Ficker Stealer data exfiltration. In AD environments, it also includes Cobalt Strike, Cobalt Strike C2 traffic and additional malware. Hancitor infections can also lead to Send-Safe spambot malware, as detailed in the flow chart shown. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image.jpeg)Figure 1. Chain of events for recent Hancitor infections.

Knowing this chain of events will better help you understand traffic  generated during a Hancitor infection. More details can be found in our  blog about [recent Hancitor infections](https://unit42.paloaltonetworks.com/hancitor-infections-cobalt-strike/).

**Pcaps of Hancitor Infection Activity**

Four password-protected ZIP archives containing five pcaps of recent Hancitor activity are available at [this GitHub repository](https://github.com/pan-unit42/wireshark-tutorial-Hancitor-traffic). From the GitHub page, click on each of the ZIP archive entries and download them, as shown in Figures 2 and 3.

![The large black arrow indicates where to click to download one of the four ZIP archives used with this Wireshark tutorial on Hancitor infections. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-1.jpeg)Figure 2. GitHub repository with links to ZIP archives used for this tutorial.

![Once a ZIP archive is selected from the GitHub repository, the large black arrow shows where to click to download it. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-2.jpeg)Figure 3. Downloading the first ZIP archive for this tutorial.

Use ***infected\*** as the password to extract pcaps from these four ZIP archives. This should give you the following five pcap files:

- Example-1-2021-02-17-Hancitor-infection.pcap
- Example-2-2021-02-10-Hancitor-infection-part-1-of-2.pcap
- Example-2-2021-02-10-Hancitor-infection-part-2-of-2.pcap
- Example-3-2021-01-25-Hancitor-infection.pcap
- Example-4-2021-02-02-Hancitor-infection.pcap

**Example 1: Hancitor with Ficker Stealer and Cobalt Strike**

Open ***Example-1-2021-02-17-Hancitor-infection.pcap\*** in Wireshark and use a basic web filter as described in our previous[ tutorial about Wireshark filters](https://unit42.paloaltonetworks.com/using-wireshark-display-filter-expressions/). The basic filter for Wireshark 3.x is:

(http.request or tls.handshake.type eq 1) and !(ssdp)

If you’ve set up Wireshark according to our initial [tutorial about customizing Wireshark displays](https://unit42.paloaltonetworks.com/unit42-customizing-wireshark-changing-column-display/), your display should look similar to Figure 4.

![The screenshot shows how your Wireshark display should look if you've set it up according to our previous tutorial about customizing Wireshark displays. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-3.jpeg)Figure 4. Our first pcap in this tutorial filtered in Wireshark.

The pcap comes from an AD environment with the following characteristics:

- LAN segment range: 10.2.17.0/24
- Domain: bean-genie.com
- Domain controller: 10.2.17.2 - Bean-Genie-DC
- LAN segment gateway: 10.2.17.1
- LAN segment broadcast address: 10.2.17.255
- IP address of the infected Windows host: 10.2.17.101
- Host name of the infected Windows host: DESKTOP-GBW8K4N
- User account name on the infected Windows host: frankie.muntz

Emails pushing Hancitor use HTTPS links to docs.google.com. In our first pcap, the 13th frame listed in the column display uses this domain name. Below, Figure 5 highlights docs.google.com in our Wireshark column display.

![A red box indicates the line that shows HTTPS traffic to docs.google.com in the pcap. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-4.jpeg)Figure 5. HTTPS traffic to docs.google.com from our first pcap.

Of note, docs.google.com is a legitimate domain, and it is not inherently malicious. However, Google Drive is frequently abused by the criminals behind Hancitor. Below, Figure 6 shows a web page from one of these URLs created by MAN1/Moskalvzapoe/TA511 for Hancitor.

![The criminals behind Hancitor frequently abuse Google Drive URLs. In the screenshot shown, the Google Docs link leads to an image of a Word doc with the following text: "Previewing is disabled. Click here to download the document." ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-5.jpeg)Figure 6. Example of Google Drive URL hosting a page for Hancitor.

Above in Figure 6, the link in "Click here to download the document"  leads to a page that provides the malicious Word document. URLs for  these pages end with .php. In many cases, these URLs also use HTTPS.  Fortunately, in this tutorial, all four examples have unencrypted HTTP  as the URL for the Word document. That makes them easy to find in our  pcaps.

Still using your basic web filter, scroll down until you see two HTTP GET requests to the same domain that end with .php. Below, Figure 7 shows these two HTTP GET requests in the Wireshark column display. They are both for:

somdeeppalace[.]com - GET /slickness.php

![Red arrows indicate the two lines in the pcap that show URLs ending in .php that deliver a malicious Word document for Hancitor. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-6.jpeg)Figure 7. Two URLs ending in .php that deliver a malicious Word document for Hancitor.

You could also use the following Wireshark filter to more quickly find these two URLs:

http.request.method eq GET and http.request.uri contains .php

Below, Figure 8 shows the results of this filter.

![The image shows the results of identifying the malicious URLs by using a Wireshark filter. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-7.jpeg)Figure 8. Filtering specifically for the two URLs.

Right-click on either HTTP GET request for slickness.php in your column display and follow the HTTP stream, as shown below in Figure 9.



![The large black arrow indicates what selections to make to follow the HTTP stream for traffic to somdeeppalace[.]com, where malicious Word documents for Hancitor are being hosted. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-8.jpeg)Figure 9. Following HTTP stream for traffic to somdeeppalace[.]com.

In the HTTP stream window, scroll down past the second set of HTTP request and response headers, then examine the HTML script after the initial <body> tag. You should find a large amount of base64 text shortly after a script function for saveAs. The beginning of this text is shown below in Figure 10.



![Red arrows indicate where you can find a script function for saveAs, as well as base64 text for the malicious Word document. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-9.jpeg)Figure 10. HTTP stream showing saveAs function followed by base64 text.

Scroll down to the end of the HTTP stream. You should find a script that offers to save a file named 0217_2857682888090.doc created from the base64 text. This is the malicious Word document. After the closing </body> tag, additional script refreshes the web page to a different URL. See Figure 11 below for details.

![Red arrows indicate a spot where, from the base64 text, the web page offers the malicious Word document for download. Also highlighted in red is the line of script that redirects to a different URL after offering the file for download. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-10.jpeg)Figure 11. Script showing file name for the malicious Word document and refreshing the browser to a different URL.

We can obtain a copy of this malicious Word document by exporting the web page from the pcap and opening it in a web browser. Since this is  malware, we recommend you do this in a non-Windows environment or a  controlled lab setting.

First, export the web page by using the following menu path, as shown below in Figure 12:

File --> Export Objects --> HTTP

![The large black arrow shows where to click to export HTTP objects from the pcap. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-11.jpeg)Figure 12. Using Wireshark to export HTTP objects from the pcap.

Find the second entry for slickness.php from somdeeppalace[.]com that is 534 kB, as shown below in Figure 13. Then save it as a web page using a file name ending with .htm or .html.

![Large black arrows indicate where to find the second entry for slickness.php, and then how to save it as a web page. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-12.jpeg)Figure 13. Saving the second entry for sickness.php from the HTTP object list.

Open your saved HTML page in a web browser. You should see a pop-up  menu including the option to save the malicious Word document. You  should also see that your web browser has been refreshed to a URL ending with the string cashplus. See Figure 14 below for details.

![Red arrows indicate the telltale element of the URL that the web browser has been redirected to, as well as the offer to save the malicious Word document. This malicious Word document caused Hancitor C2 traffic when we tested it. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-13.jpeg)Figure 14. Viewing your saved HTML page in a web browser.

This malicious Word document caused Hancitor C2 traffic that starts less than two minutes later in the pcap.

#### **What does Hancitor C2 traffic look like?**

Hancitor first causes an IP address check to api.ipify.org by the infected Windows host. Then it causes the C2 traffic. Hancitor C2 traffic consists of HTTP POST URLs that end with /8/forum.php.

Of note, traffic to api.ipify.org is an indicator, but it’s not inherently malicious by itself.

Using your basic web filter, scroll down to find an IP address check to api.ipify.org followed by the first HTTP POST request for Hancitor C2 traffic to thavelede[.]ru. Below, Figure 15 shows where you can find these two items.

![Red arrows indicate where in the Wireshark column display the IP address check and the Hancitor C2 traffic are shown. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-14.jpeg)Figure 15. IP address check followed by Hancitor C2 noted in the Wireshark column display.

Since November 2020, URLs for Hancitor C2 traffic have always ended with /8/forum.php. The easiest way to check for Hancitor-specific traffic in Wireshark is using the following filter:

http.request.uri contains "/8/forum.php" or http.host contains api.ipify.org

The above Wireshark filter should show you Hancitor’s IP address  check followed by HTTP POST requests for Hancitor C2 traffic, as shown  below in Figure 16.

![The screenshot shows how the Wireshark column display should appear after using a filter that searches for Hancitor-specific traffic using known indicators of Hancitor. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-15.jpeg)Figure 16. Filtering for Hancitor-specific traffic in Wireshark.

- api.ipify.org - GET /
- thavelde[.]ru - POST /8/forum.php
- zinsubtal[.]ru - POST /8/forum.php

The results also include the following HTTP GET request generated by Ficker Stealer malware:

- api.ipify.org - GET /?format=xml

We will cover Ficker Stealer traffic later. First, let us examine how Hancitor sends its followup malware.

Hancitor uses a specific domain to send Ficker Stealer and Cobalt  Strike as followup malware. This domain changes each day Hancitor is  active, but you should see three HTTP GET requests to the same domain  for followup malware. One of the URLs ends with .exe, which is for Ficker Stealer. Two of the URLs end with .bin, which are for Cobalt Strike.

Use the following Wireshark filter to find URLs for Ficker Stealer and Cobalt Strike:

http.request.uri contains .exe or http.request.uri contains .bin

The results are shown below in Figure 17.

![The screenshot shows how the Wireshark column display should appear after using a filter to find URLs for Ficker Stealer and Cobalt Strike. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-16.jpeg)Figure 17. Filtering for Hancitor sending Cobalt Strike and Ficker Stealer.

As shown above in Figure 17, filtering for followup malware from Hancitor should reveal the following traffic in our first pcap:

- belcineloweek[.]ru - GET /6sufiuerfdvc.exe
- belcineloweek[.]ru - GET /1602s.bin
- belcineloweek[.]ru - GET /1602s.bin

The first HTTP GET request returned an EXE file for Ficker Stealer.  The next two HTTP GET requests returned encoded data used to infect the  victim with Cobalt Strike.

#### What does Ficker Stealer infection traffic look like?

Ficker Stealer is the same EXE file for several weeks at a time.  Since 2021-01-20 until as recently as 2021-03-04, the SHA256 hash for  Ficker Stealer has been:

94e60de577c84625da69f785ffe7e24c889bfa6923dc7b017c21e8a313e4e8e1

The above EXE for Ficker Stealer causes an IP address check to api.ipifiy.org/?format=xml, which is not inherently malicious on its own. Ficker Stealer then generates a DNS query for sweyblidian[.]com and sends non-HTTP traffic over TCP port 80 to that domain. This  traffic consists of data stolen from the infected Windows host.

To find the IP address used for sweyblidian[.]com, search for the associated DNS query using the following Wireshark filter:

dns.qry.name contains sweyblidian

The answer to this query is the IPv4 address 185.100.65[.]29, as shown below in Figure 18.



![The red arrow indicates the IP address used for sweyblidian[.]com](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-17.jpeg)Figure 18. Finding the IP address used for sweyblidian[.]com.

Find any TCP streams to that IP address using the following Wireshark filter:



ip.addr eq 185.100.65.29 and tcp.flags eq 0x0002

The results should reveal three TCP SYN segments for two TCP streams  (one of the TCP SYN segments is a retransmission), as shown below in  Figure 19.



![The screenshot shows how the Wireshark column display should appear after filtering for TCP streams to the IP address used for sweyblidian[.]com.](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-18.jpeg)Figure 19. TCP SYN segments for two TCP streams to the IP address for sweyblidian[.]com.

Follow the TCP stream with port 49807 as the TCP source port. This should show approximately 1.16 MB of data. The majority of it appears encoded or  otherwise obfuscated, as shown below in Figure 20.



![The screenshot shows how the majority of data from the TCP stream appears encoded or otherwise obfuscated. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-19.jpeg)Figure 20. TCP stream showing the start of data exfiltrated by Ficker Stealer.

After exfiltrating its data, Ficker Stealer goes quiet and we don’t  see anything more from it. At this point, if the infected computer is a  standalone Windows host, we will only see Hancitor C2 traffic. But if  the infected computer is part of an AD environment, we should also see  Cobalt Strike.

Let’s look at the initial requests for Cobalt Strike by Hancitor using the following Wireshark filter:

http.request.uri contains .bin

This should return the following lines:

- belcineloweek[.]ru - GET /1602s.bin
- belcineloweek[.]ru - GET /1602s.bin

Follow the TCP stream for either of those HTTP GET requests. This TCP stream contains all three HTTP GET requests and responses to and from belcineloweek[.]ru, so you must scroll past a large amount of data representing the Ficker  Stealer EXE. Near the end of the TCP stream, you should find two  identical HTTP GET requests for 1602s.bin. Both requests return the same 682 bytes of data as shown below in  Figure 21. This data is used to infect the victim with Cobalt Strike.

![The screenshot shows the 682 bytes of data used to infect a victim of a Hancitor infection in an AD environment with Cobalt Strike. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-20.jpeg)Figure 21. TCP stream showing 682 bytes of data returned from belcineloweek[.]ru for Cobalt Strike.

#### What does Cobalt Strike traffic look like?

It can be HTTP or HTTPS. In this pcap, HTTP GET requests by Hancitor  for Cobalt Strike use the letter s in the URLs. The request for 1602s.bin indicates Cobalt Strike for this infection uses HTTPS traffic.

That is indeed what happened. Use your basic web traffic filter, then scroll down, and you should see several frames in the column display to 192.99.250[.]2 over TCP port 443 as shown below in Figure 22. This is Cobalt Strike  traffic. Cobalt Strike traffic to this IP address does not have an  associated domain, so the host name is blank in the column display.

![Red arrows indicate the lines in the Wireshark column display that relate to traffic from the infected Windows host caused by Cobalt Strike. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-21.jpeg)Figure 22. Traffic from the infected Windows host caused by Cobalt Strike.

Certificate issuer data for HTTPS traffic caused by Cobalt Strike  HTTPS is unusual. Why? Because all of the identification fields for  items like country, locality and organization are blank. We can filter  for certificate data in Cobalt Strike’s HTTPS traffic and expand the  frame details to see this.

First, find certificate data from the IP address for Cobalt Strike traffic by using the following Wireshark filter:

tls.handshake.type eq 11 and ip.addr eq 192.99.250.2

This should reveal two frames in your column display. Expand frame  details for either of these frames until you find fields for certificate issuer data. These fields should be blank. Below, Figure 23 shows an  example.

![A red arrow and box highlight the blank certificate issuer data for Cobalt Strike HTTPS traffic. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-22.jpeg)Figure 23. Certificate issuer data for Cobalt Strike traffic.

For the rest of this pcap, we see HTTP GET requests for Hancitor C2  and HTTPS traffic for Cobalt Strike. Hancitor C2 traffic happens  approximately every 2 minutes. HTTPS traffic for Cobalt Strike happens  nearly every second.

**Example 2, Part 1: Hancitor with Ficker Stealer and Cobalt Strike**

Open ***Example-2-2021-02-10-Hancitor-infection-part-1-of-2.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 24.

![The screenshot shows the Wireshark column display after opening the Example 2, part 1 pcap and applying a basic web filter. A Google Docs link is highlighted in blue. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-23.jpeg)Figure 24. Traffic from part one of our second example filtered in Wireshark using a basic web filter.

The pcap comes from an AD environment with the following characteristics:

- LAN segment range: 10.2.10.0/24
- Domain: pizzawithapples.food
- Domain controller: 10.2.10.10 - Apples-DC
- LAN segment gateway: 10.2.10.1
- LAN segment broadcast address: 10.2.10.255
- IP address of the infected Windows host: 10.2.10.101
- Host name of the infected Windows host: DESKTOP-TRH50EJ
- User account name on the infected Windows host: dave.thomas

Above in Figure 24, we see a link to docs.google.com followed by HTTP GET requests to b2b.ebike-your-life[.]com/commemorative.php. As we did in our first example, we can export the HTML page from b2b.ebike-your-life[.]com from our second example and open it in a web browser to get the malicious Word document.

The SHA256 hash for your Word document should be 793d134cdb4bcba47e1f678d052c4d7747b93ea4199714efb8b614321b58dca7, and its name should be 0210_1723194332604.doc.

Also as we did for our first example, find Hancitor C2 activity using the following Wireshark filter:

http.request.uri contains "/8/forum.php" or http.host contains api.ipify.org

This returns IP address checks by Hancitor and Ficker Stealer, along  with Hancitor C2 traffic, as listed below and shown in Figure 25.

- api.ipify.org - GET /
- anumessensan[.]ru - POST /8/forum.php
- api.ipify.org - GET /?format=xml

![The screenshot shows the results of filtering for IP address checks by Hancitor and Ficker Stealer, along with Hancitor C2 traffic. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-24.jpeg)Figure 25. IP address checks and Hancitor C2 traffic.

Filter for followup malware sent by Hancitor using the following Wireshark filter:

http.request.uri contains .exe or http.request.uri contains .bin

This should reveal Hancitor sending followup malware for Cobalt  Strike and Ficker Stealer, as listed below and shown in Figure 26:

- backupez[.]com - GET /0902.bin
- backupez[.]com - GET /0902s.bin
- backupez[.]com - GET /6yudfgh.exe

![The screenshot shows the results of filtering the Wireshark column display for followup malware sent by Hancitor. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-25.jpeg)Figure 26. Hancitor sends follow-up malware for Cobalt Strike and Ficker Stealer.

In this case, one of the GET requests for Cobalt Strike has an s in  the URL, but the other does not, so we should see both HTTP and HTTPS  traffic caused by the Cobalt Strike.

Return to your basic web filter, then scroll down to see what type of HTTP requests happen after the traffic to backupez[.]com. The results should show HTTP traffic over TCP port 1080 and HTTPS traffic over TCP port 4443.

Your Wireshark setup might not display any HTTP traffic over TCP port 1080, so you might have to set up Wireshark to show it. First, use the  menu path ***Analyze --> Decode As\*** shown below in Figure 27 to bring up the ***Decode As\*** window.

![The large black arrow shows where to click in Wireshark to bring up the Decode As window. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-26.jpeg)Figure 27. Menu path for the Decode As window.

Once you have the Decode As window, create a new entry to decode TCP port 1080 as HTTP, as shown below in Figure 28.

![The large black arrows show where to click to create a new entry to decode TCP port 1080 as HTTP. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-27.jpeg)Figure 28. Creating a new entry in the Decode As window to decode TCP port 1080 as HTTP.

When you’ve created the new entry, either click the OK button or  click the Save button. The Save button literally saves the entry, so it  will work after you close and open Wireshark again. The OK button  applies the decoding only as long as your current Wireshark session  stays open.

In this case, we should click the Save button.

After saving the entry, go back to your Wireshark column display and  use the basic web filter. Scroll down, and you should see both HTTP and  HTTPS traffic for Cobalt Strike, as highlighted below in Figure 29.

![Red arrows and boxes indicate traffic caused by Cobalt Strike in our second example. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-28.jpeg)Figure 29. Traffic caused by Cobalt Strike in our second example.

Shown above in Figure 29, traffic caused by Cobalt Strike is:

- 104.160.190[.]114:8080 - GET /WWFh
- 104.160.190[.]114:8080 - GET /fwlink
- 104.160.190[.]114 port 4443 - HTTPS traffic

The first HTTP GET request, ending with WWFh, returned 208,473 bytes  of an encoded binary that most likely decodes to a Windows binary used  for Cobalt Strike. Follow the TCP stream for this HTTP request, and you  should see information shown below in Figure 30.



![The information shown is obtained by following the TCP stream for the first HTTP GET request found in our second example, the one ending with WWFh. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-29.jpeg)Figure 30. TCP stream of the initial HTTP GET request to 104.160.190[.]114:8080.

Further HTTP traffic to 104.160.190[.]114:8080 for fwlink is Cobalt Strike C2 traffic. This traffic also returns encoded data, if it returns any data at all. In most cases, zero bytes of content are  returned. The first HTTP request to 104.160.190[.]114:8080 for fwlink returned 48 bytes of encoded data, as shown below in Figure 31.





![The first HTTP request to 104.160.190[.]114:8080 for fwlink returned 48 bytes of encoded data, shown here. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-30.jpeg)Figure 31. First HTTP request for Cobalt Strike C2 traffic returned 48 bytes of data.

These HTTP requests for Cobalt Strike C2 happen approximately once every  second. HTTPS traffic for Cobalt Strike C2 is similarly busy, with  traffic to 104.160.190[.]114 over TCP port 4443 appearing approximately once every second.



Our next pcap for our second example is from later during the same  infection, when we see indicators of Send-Safe spambot malware.

**Example 2, Part 2: Hancitor C2, Cobalt Strike C2 and Send-Safe Spambot Malware**

Open ***Example-2-2021-02-10-Hancitor-infection-part-2-of-2.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 32.

![The screenshot shows how your Wireshark column display should look after applying a basic web filter to traffic from part two of our second example. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-31.jpeg)Figure 32. Traffic from part two of our second example filtered in Wireshark using a basic web filter.

This pcap happens later during the same infection as our previous  pcap. At times, we see up to three or four HTTP GET requests for Cobalt  Strike C2 traffic during the same second.

However, this pcap reveals that Hancitor sent another Windows  executable file, and that executable is Send-Safe-based spambot malware.

To find this Windows executable file, use the following Wireshark filter:

http.request.uri contains .exe

The result is another HTTP GET request to backupez[.]com, which is the domain used by Hancitor to push followup malware in part one of this example. The URL ends with 47.exe. See the result below in Figure 33.

![Using a Wireshark filter designed to identify .exe files, we retrieve the Windows executable for Send-Safe spambot malware, shown here. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-32.jpeg)Figure 33. Hancitor retrieves Windows executable for Send-Safe spambot malware.

You can export this file from the pcap using the menu path ***File --> Export Objects --> HTTP.\*** Select the entry for 47.exe from backupez[.]com, as shown below in Figure 34.

![The red arrow indicates the steps required to export the Windows executable for Send-Safe spambot malware from the pcap. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-33.jpeg)Figure 34. Exporting the Send-Safe spambot EXE from the pcap.

The SHA256 hash of 47.exe is:

51ca66a8ac7f4e072b39ef886d7d414d6c6868d0d67a46150835297e65493dc6

Send-Safe was a commercially available program sold through a now-defunct website named send-safe[.]com. It was advertised as "[...a  bulk-emailing program that allows you to send email from your own  computer, or a remote computer with or without the use of proxies.](http://web.archive.org/web/20190918103313/www.send-safe.com/send-safe.html)"

This program has been used by various threat actors as malware to turn infected Windows computers into spambot hosts.

What does Send-Safe spambot traffic look like? Our infected Windows host generated the following traffic:

- HTTPS traffic to 31.44.184[.]47 over TCP port 50025
- Traffic to 31.44.184[.]47 over UDP port 50026
- SMTP traffic sending out malicious spam pushing Hancitor.

To find Send-Safe UDP traffic, use udp.port eq 50026 for your Wireshark filter. The results should look like Figure 35 below.

![The screenshot shows how your Wireshark column display should look after you filter to find Send-Safe UDP traffic. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-34.jpeg)Figure 35. UDP traffic caused by Send-Safe-based spambot malware.

To view Send-Safe SMTP traffic and HTTPS traffic, use the following Wireshark filter:

(tcp.port eq 50025 and tls.handshake.type eq 1) or smtp.data.fragment

Your results should look similar to Figure 36.

![This shows an example of the results of filtering for Send-Safe SMTP traffic and HTTPS traffic after a Hancitor infection. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-35.jpeg)Figure 36. HTTPS and spambot traffic caused by Send-Safe-based malware.

HTTPS traffic over TCP port 50025 caused by Send-Safe has certificate issuer data that uses Send-Safe as the organizationName and commonName, as shown below in Figure 37.

![HTTPS traffic over TCP port 50025 caused by Send-Safe has certificate issuer data that uses Send-Safe as the organizationName and commonName, as shown here. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-36.jpeg)Figure 37. Send-Safe-specific certificate issuer data in HTTPS traffic caused by Send-Safe malware.

Since the SMTP traffic in this pcap is unencrypted, you can extract the emails using Wireshark. The menu path is ***File --> Export Objects --> IMF\*** as shown below in Figure 38.

![The red arrow indicates the selections to make to extract malicious emails caused by Send-Safe spambot malware in this example. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-37.jpeg)Figure 38. Exporting emails caused by the Send-Safe spambot malware.

This pcap contains 167 emails you can export. On average, several  messages were pushed out each second from this Send-Safe-infected  Windows host.

Below, Figure 39 shows what one of the exported items of Hancitor  spam looks like in a Thunderbird email client. The template for this  specific wave of Hancitor spam spoofed a well-known bank.

![A Hancitor email exported from the pcap is designed to spoof a well-known bank. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-38.jpeg)Figure 39. An example of a Hancitor email exported from the pcap.

**Example 3: Hancitor with Ficker Stealer, Cobalt Strike and a Network Ping Tool**

Open ***Example-3-2021-01-25-Hancitor-infection.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 40.

![The screenshot shows how your Wireshark display should look after opening traffic from example three and applying a basic web filter. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-39.jpeg)Figure 40. Traffic from the fourth pcap filtered in Wireshark using our basic web filter.

The pcap comes from an AD environment with the following characteristics:

- LAN segment range: 10.1.25.0/24
- Domain: permafrostie.com
- Domain controller: 10.1.25.2 - Permafrostie-DC
- LAN segment gateway: 10.1.25.1
- LAN segment broadcast address: 10.1.25.255
- IP address of the infected Windows host: 10.1.25.101
- Host name of the infected Windows host: DESKTOP-GAL3OV5
- User account name on the infected Windows host: barry.paulsen

The page that delivered the initial Word document was www.nuicala.inspia[.]net/mars.php. As we did in our two previous examples, we can export the web page,  open it in a browser and get the malicious Word document used to kick  off this Hancitor infection.

The SHA256 hash and name for the extracted malicious Word document is:

8922dbb1e7f157c62fe64d03278757d78d136eb94d00ac2df101789d602f1224 0125_206410993.doc

Based on techniques from our first two examples, you can find the following information from this Hancitor infection:

Hancitor traffic:

- port 80 - api.ipify.org - GET /
- 83.220.169[.]45 port 80 - wasintodese[.]ru - POST /8/forum.php

Followup malware for Cobalt Strike:

- 8.209.78[.]68 port 80 - drivewaysnowservice[.]com - GET /2101.bin
- 8.209.78[.]68 port 80 - drivewaysnowservice[.]com - GET /2101s.bin

Followup malware for Ficker Stealer

- 8.209.78[.]68 port 80 - drivewaysnowservice[.]com - GET /6gfbd5ws.exe

Cobalt Strike traffic:

- 23.106.80[.]14 port 1080 - 23.106.80[.]14:1080 - GET /JdHf
- 23.106.80[.]14 port 1080 - 23.106.80[.]14:1080 - GET /match
- 23.106.80[.]14 port 1080 - 23.106.80[.]14:1080 - POST /submit.php?id=2612103345
- 23.106.80[.]14 port 4443 - HTTPS traffic

Ficker Stealer traffic:

- port 80 - api.ipify.org - GET /?format=xml
- 185.100.65[.]29 port 80 - sweyblidian[.]com - TCP traffic

Of note, Ficker Stealer is the same binary for all examples in this  tutorial, so we should see the same post-infection traffic by this  malware. For Cobalt Strike, any HTTP POST request containing /submit.php?id= has an identification number that’s unique for each infected Windows host.

If you see these HTTP POST requests with /submit.php?id= from Cobalt Strike, be alert for indicators of additional malware.

Malware sent through Cobalt Strike appears as an encoded binary that  is decoded on the victim host. Because of this, we will not find the  actual malware binary in the pcap. Instead, followup malware sent  through Cobalt Strike is identified by its post-infection traffic.

In this case, we see ICMP scanning that indicates a [network ping tool](https://unit42.paloaltonetworks.com/hancitor-infections-cobalt-strike/) was sent through Cobalt Strike. Use the Wireshark filter icmp in the pcap, and your column display should look similar to Figure 41 below.

![The screenshot displays an example of how ICMP traffic from a network ping tool sent through Cobalt Strike should look after you apply the Wireshark filter icmp to the example pcap. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-40.jpeg)Figure 41. ICMP traffic from a network ping tool sent through Cobalt Strike.

As described in our recent blog about [Hancitor](https://unit42.paloaltonetworks.com/hancitor-infections-cobalt-strike/), samples of the network ping tool recovered from infected Windows hosts  generate approximately 1.5 GB of ICMP traffic, as they ping more than 17 million IP addresses targeting internal, non-routable IPv4 address  space.

Based on our tests, these network ping tools hit the following address space:

- 192.168.0.0 through 192.168.254.254
- 172.16.0.0 through 172.31.254.254
- 10.0.0.0 through 10.254.254.254

This much ping traffic is prohibitively slow to display in Wireshark. The pcap for our third example of Hancitor has ping traffic to 192.168.0.0/16 and some of the ping traffic hitting the 172.16.0.0/12 address space before the recording was stopped.

**Example 4: Hancitor with Ficker Stealer, Cobalt Strike and NetSupport Manager RAT**

Open ***Example-4-2021-02-02-Hancitor-infection.pcap\*** in Wireshark and use a basic web filter, as shown in Figure 42.

![The screenshot shows how your Wireshark display should look after opening traffic from example four and applying a basic web filter. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-41.jpeg)Figure 42. Traffic from the fifth pcap filtered in Wireshark using our basic web filter.

The pcap comes from an AD environment with the following characteristics:

- LAN segment range: 10.2.2.0/24
- Domain: sillybobcat.com
- Domain controller: 10.2.2.2 - Cats-DC
- LAN segment gateway: 10.2.2.1
- LAN segment broadcast address: 10.2.2.255
- IP address of the infected Windows host: 10.2.2.101
- Host name of the infected Windows host: DESKTOP-NDGEE4D
- User account name on the infected Windows host: baxter.murdoch

The page that delivered the initial Word document was premierpt.co[.]uk/footage.php. As we did for our previous examples, we can export the web page, open  it in a browser and get the malicious Word document used to kick off  this Hancitor infection.

The SHA256 hash and name for the extracted malicious Word document is:

b60431e0fe5bf2b5c7cd5e01add62d24cd6ad2c99eb6a23fb5a2967d812cbf08 0202_10846666250132.doc

Based on techniques from our previous examples, you can find the following information from this Hancitor infection:

Hancitor traffic:

- port 80 - api.ipify.org - GET /
- 45.9.191[.]107 port 80 - knorshand[.]ru - POST /8/forum.php

Followup malware for Cobalt Strike:

- 8.209.78[.]68 port 80 - bobcatofredding[.]com - GET /0102.bin
- 8.209.78[.]68 port 80 - bobcatofredding[.]com - GET /0102s.bin

Followup malware for Ficker Stealer

- 8.209.78[.]68 port 80 - bobcatofredding[.]com - GET /6lavfdk.exe

Cobalt Strike traffic:

- 192.254.79[.]71 port 8080 - 23.106.80[.]14:1080 - GET /EbHm
- 192.254.79[.]71 port 8080 - 23.106.80[.]14:1080 - GET /ptj
- 192.254.79[.]71 port 8080 - 23.106.80[.]14:1080 - POST /submit.php?id=242569267
- 192.254.79[.]71 port 443 - HTTPS traffic

Ficker Stealer traffic:

- port 80 - api.ipify.org - GET /?format=xml
- 185.100.65[.]29 port 80 - sweyblidian[.]com - TCP traffic

As we discussed in our previous example, if you see HTTP POST requests with /submit.php?id= from Cobalt Strike, be alert for indicators of additional malware. Also like our previous example, we cannot find the malware binary in the  pcap, so we must identify followup malware by its post-infection  traffic.

In this case, we find indicators for NetSupport Manager RAT malware.

This RAT first does an IP address check to the domain geo.netsupportsoftware[.]com . Then it generates traffic with NetSupport Manager as part of the User-Agent string in its HTTP request headers.

Search for this traffic by using the following Wireshark display filter:

http.user_agent contains "NetSupport Manager" or http.host contains netsupport

The results should look similar to Figure 43 below:

![This is an example of how traffic generated by NetSupport Manager RAT should appear in Wireshark after being surfaced by the suggested "NetSupport Manager" filter. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-42.jpeg)Figure 43. Traffic generated by NetSupport Manager RAT.

Traffic seen above in Figure 43 is:

- 62.172.138[.]35 port 80 - geo.netsupportsoftware[.]com - GET /location/loca.asp
- 46.17.106[.]230 port 3543 - 46.17.106[.]230 - POST hxxp://46.17.106[.]230/fakeurl.htm

Follow the TCP stream for any of the HTTP POST requests to see what  NetSupport Manager C2 traffic looks like. The results should look  similar to Figure 44 below.

![The screenshot shows an example of data from a TCP stream of NetSupport Manager RAT C2 traffic. ](https://unit42.paloaltonetworks.com/wp-content/uploads/2021/04/word-image-43.jpeg)Figure 44. TCP stream of NetSupport Manager RAT C2 traffic.

Of note, this tutorial only contains two examples of followup traffic from Cobalt Strike after a Hancitor infection. Cobalt Strike can be  used to send other types of malware, not just a network ping tool or  NetSupport Manager RAT.

So if you examine activity from a Hancitor infection with Cobalt  Strike, we recommend you search for indicators from any other type of  malware.

