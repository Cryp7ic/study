DNS over HTTPS is a protocol for performing remote Domain Name System resolution via the HTTPS protocol. A goal of the method is to increase user privacy and security by preventing eavesdropping and manipulation of DNS data by man-in-the-middle attacks by using the HTTPS protocol to encrypt the data between the DoH client and the DoH-based DNS resolver.

  

## Encrypted DNS Is More Private and Secure

Every time you visit a website using a domain name (such as “google.com,” for example), your computer sends a request to a [Domain Name System (DNS) server](https://www.howtogeek.com/122845/htg-explains-what-is-dns/). The DNS server takes the domain name and looks up the matching IP address from a list. It sends the IP address back to your computer, which your computer then uses to connect to the site.

This domain name fetching process traditionally happened unencrypted on the network. Any point in between could intercept the domain names of the sites you are visiting. With [DNS over HTTPS](https://www.howtogeek.com/448629/how-dns-over-https-doh-will-boost-privacy-online/), also known as DoH, the communications between your computer and a DoH-enabled DNS server are encrypted. No one can intercept your DNS requests to snoop on the addresses you’re visiting or tamper with the responses from the DNS server.


How to Enable DNS Over HTTPS on Windows 11:

  

## First, Choose a Supported Free DNS Service

As of Windows 11’s release, DNS over HTTPS in Windows 11 only works with a certain hard-coded list of [free DNS services](https://www.howtogeek.com/664608/why-you-shouldnt-be-using-your-isps-default-dns-server/) (you can see the list yourself by running netsh dns show encryption in a [Terminal window](https://www.howtogeek.com/673729/heres-why-the-new-windows-10-terminal-is-amazing/)).

Here’s the current list of supported [IPv4](https://www.howtogeek.com/242443/why-do-i-have-ipv4-and-ipv6-public-addresses-assigned-to-my-home-network/) DNS service addresses as of November 2021:

-   Google DNS Primary: 8.8.8.8
-   Google DNS Secondary: 8.8.4.4
-   Cloudflare DNS Primary: 1.1.1.1
-   Cloudflare DNS Secondary: 1.0.0.1
-   Quad9 DNS Primary: 9.9.9.9
-   Quad9 DNS Secondary: 149.112.112.112
    

For [IPv6](https://www.howtogeek.com/119619/htg-explains-why-the-internet-is-running-out-of-ipv4-addresses-and-why-ipv6-is-important/), here is the  list of supported DNS service addresses:

-   Google DNS Primary: 2001:4860:4860::8888
-   Google DNS Secondary: 2001:4860:4860::8844
-   Cloudflare DNS Primary: 2606:4700:4700::1111
-   Cloudflare DNS Secondary: 2606:4700:4700::1001
-   Quad9 DNS Primary: 2620:fe::fe
-   Quad9 DNS Secondary: 2620:fe::fe:9
    

When it comes time to enable DoH in the section below, you’ll need to choose two pairs of these DNS servers—primary and secondary for IPv4 and IPv6—to use with your Windows 11 PC. As a bonus, using these will very likely [speed up](https://www.howtogeek.com/664608/why-you-shouldnt-be-using-your-isps-default-dns-server/) your internet browsing experience.

## Next, Enable DNS over HTTPS in Windows 11

To get started setting up DNS over HTTPS, open the Settings app by pressing Windows+i on your keyboard. Or you can right-click the Start button and select “Settings” in the special menu that appears.

![In Windows 11, right-click the Start button and select "Settings."](https://lh6.googleusercontent.com/gYvKdoj2zymfUn3KWw2m5xFngLQW_btCwtQvw4RLdsM3Wfnp88pMLSMJSjYlsg3AuNIuRjV5ZIBIfzAd4n_JsUddXFGbIAWbz4qfArPQC7-Uq4Tf-gLbQcgbMcTeKv8qCRBD3yGn)

In Settings, click “Network & Internet” in the sidebar.

![In Windows 11 Settings, click "Network & Internet."](https://lh5.googleusercontent.com/UaDVlKQ6sPGCvOHskRKM4-iqdIXw967-OClzhSP4PtTLVb1x6-5UYozaBIxRQhtvpCUgPcxSj1GSeXd06jKcM-MoMQ9bmeDxJTsvAWixE6Z1QuPEwlQ27AIB-PS402im-5TxBVJl)

In Network & Internet settings, click the name of your primary internet connection in the list, such as “Wi-Fi” or “Ethernet.” (Don’t click “Properties” near the top of the window—that won’t let you encrypt your DNS connections.)

![In Network & Internet settings, click the name of your primary network connection in the list.](https://lh4.googleusercontent.com/uDVvfj67265aoFoHeJvaXXZSgWq3XNIYzXG7Wkd5K_09PgSPwMoAJxeE6xvft6B5Ai2X373bhAr-NojaYDYr9J5EcBkDY2hBvDWt2iVFIi6-PjxiBEOoe-jNAa9aH57ahzsdSH3J)

On the network connection’s properties page, select “Hardware Properties.”

![Select "Hardware Properties."](https://lh6.googleusercontent.com/_8YPrStrmx1RY9xeWdXhlGYB6_J8w7BfEJCAyx6kMRKdU2NFG33lBzQShxduYIHT6afOApmYB5a9UOGDdwD7tDY8mtM9BsFpUAjZ0Sif4d3ytq8PvmMjO5CVwJTGb9jC5j_rS9Ug)

On the Wi-Fi or Ethernet hardware properties page, locate the “DNS Server Assignment” option and click the “Edit” button beside it.

![Click "Edit."](https://lh3.googleusercontent.com/xRroLxE-oATwVxB0gcdpm_wZOiylbTqZ-XEDl_jl_gGR5vAl6M8OjvQ30y7WXWUFNWeLvWT_73Sa9JWcTOpX5qkOHlZDqLnYoCpCRxu2GWIJQYmObxIH0S_vR8dF4pl7g5asChf3)

In the window that pops up, use the drop-down menu to select “Manual” DNS settings. Then flip the “IPv4” switch to the “On” position.

![Set the drop-down box to "Manual" and turn "IPv4" to "On."](https://lh5.googleusercontent.com/8CI6EHjVU9YjuSJSn4Yc7SJdI1Z5ejSBCHEBwzWCEi_S6K1qvcVTci1IrvIUjYjniRvWfmxmqslrwv6cGgiRbOeV_x6cElt9M-PQNhZMe0xjDO_fDMq-ST4PJRkkwWmXMRc9f8q3)

In the IPv4 section, enter the primary DNS server address you chose from the [section above](https://www.howtogeek.com/765940/how-to-enable-dns-over-https-on-windows-11/#moka_anchor_DNS_Service) in the “Preferred DNS” box (such as “8.8.8.8”). Similarly, enter the secondary DNS server address in the “Alternate DNS” box (such as “8.8.4.4”).

Tip: If you don’t see the DNS encryption options, then you’re editing the DNS settings for your Wi-Fi SSID. Make sure you select the connection type in Settings > Network & Internet, then click “Hardware Properties” first.

![Enter your DNS server addresses.](https://lh6.googleusercontent.com/13tqoofl4Fm8Isy2feJPKCNBIix8M-2yCjiSVy2PK1Ymtbys3-2McOICoQ3UiALVfTU4sstUL_kjkRpU1SLfDFlQrx_pvqkRbm8lNqjwmarESjyGS0OdTuahdo37gd79bjL_NUmq)

In the same window, set “Preferred DNS Encryption” and “Alternate DNS Encryption” to “Encrypted Only (DNS over HTTPS)” using the drop-down boxes below the DNS addresses you entered in the last step.

![Set the DNS servers to "Encrypted Only."](https://lh3.googleusercontent.com/qYi4MZ24TYISbwqZq6lTuhHsQU6b2eMN_louw_OwGlTtQNFeGv9ksu9BssiAwGTFCq62MS8FZpHdRvILACCYluDzNUlrRzkO1WJ_DElmuGLc6HV5TMrKhAJYSfhAmgb3pXBTkVCD)

After that, repeat this process with IPv6.

Flip the IPv6 switch to the “On” position, and then copy a primary IPv6 address in the [section above](https://www.howtogeek.com/765940/how-to-enable-dns-over-https-on-windows-11/#moka_anchor_DNS_Service) and paste it into the “Preferred DNS” box. Next, copy a matching secondary IPv6 address and paste it into the “Alternate DNS” box.

After that, set both “DNS encryption” settings to “Encrypted Only (DNS over HTTPS).” Finally, click “Save.”

![Add new DNS servers for IPv6 and click "Save."](https://lh4.googleusercontent.com/dAjI-JqRir-5Zw-sUXullFnhobYVYW4raYlmR1FcBz8stZ0LrAAUEdUV8t6_dLFn8IU_iuGXGhK-CiXBPrVcWfwxf84LtUA1IZ8BuxjjT4ASO951qhHIolDVl3D6YMZ6nE-B3PzW)

Back on the Wi-Fi or Ethernet hardware properties page, you’ll see your DNS servers listed with an “(Encrypted)” beside each one of them.

![You'll see "(Encrypted)" beside the DNS server names.](https://lh4.googleusercontent.com/gxgkxD57Z6IlHyC7G9AkWezbX91gMDNjf4ypqfLFEYvlc3xZ0WjkllpwH9_rbBrqifNBIBBbfeT0b6qnlb7sHcVjhxKNMy4Ya26DYcum3Rt3Jko6inhoNF8TXEcfVH8AJ3auc3ER)

That’s all you need to do. Close the Settings app, and you’re ready to go. From now on, all of your DNS requests will be private and secure. Happy browsing!

Note: If you experience network problems after changing these settings, be sure to check that you entered the IP addresses correctly. A mistyped IP address would result in the DNS servers being unreachable. If the addresses appear to be typed correctly, try disabling the “IPv6” switch in the DNS servers list. If you configure IPv6 DNS servers on a computer without IPv6 connectivity, this could cause connectivity issues.

  
  

Source: howtogeek.com