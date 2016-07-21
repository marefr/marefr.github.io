---
date: 2016-07-21 13:30
title: 'DIY pfSense Firewall/Router Part 2: Installation'
published: true
summary: ""
categories: [ "diy" ]
tags: [ "pfSense", "firewall", "router" ]
image:
  thumbnail:
    src: /public/uploads/pfsense-logo-thumb.png
    alt: pfSense logo
sitemap:
  lastmod: 2016-07-21 14:30
---

In the [first part]({% post_url 2016-07-19-diy-pfsense-firewall-router-part-1-introduction %}) I introduced pfSense and the hardware I'm using for building my firewall/router. In this part I'll show how to install pfSense and do some general setup.

<!-- more -->

## Installation
The official pfSense documentation is actually really good so I recommend you to follow the [Installing pfSense](https://doc.pfsense.org/index.php/Installing_pfSense) to get a fresh installation in place.

I used a USB thumb drive and made it a bootable drive with 64-bit Memstick VGA image (as of writing pfSense-CE-memstick-2.3.1-RELEASE-amd64.img). I choosed the full installation, i.e. installed pfSense on my internal 8GB SSD drive.

First, the installer console can be changed to use a different font, screenmap, or keymap. Most people do not need to change these, but it may help with some international keyboards.

I've actually had some needs of using an attached keyboard in the FreeBSD shell after the installation to do some tasks and it's really a pain in the ass with a Swedish keyboard and an american/english keymap setting (default). I didn't find an easy way to change the keymap after the installation so changing the keymap settings during installation is something that I would take into consideration.

Second, in the installer console I went for the Custom Install just to be sure that I was going to install it on the SSD drive and not the USB thumb drive. Going through the custom install lets you format and partition your selected disk. Besides formatting and partioning you  basically choose Yes, Accept and Create. Easy as that. If you're unsure you can have a look at step 8 to 17 in [this article](http://www.tecmint.com/how-to-install-and-configure-pfsense/), it should be fine even though an older version of pfSense are referenced.

## Connect and configure WAN and LAN
After the installation is complete, a shell menu is presented on the console with a number of options. If the installation identified your two Ethernet ports as em0 (WAN) and em1 (LAN) you can see those above the console menu. If so DHCP should already have been setup for your WAN interface and a static IPv4 address should have been assigned to your LAN interface which means that you now should be able to connect your computer to the LAN port on the pfSense and connect to the WebGUI by browsing the assigned IPv4 address (shown above the console menu), usally this is https://192.168.1.1.

<a href="/public/uploads/Installer_08_consolemenu.png">![pfSense console shell menu screenshot](/public/uploads/Installer_08_consolemenu.png "pfSense console shell menu screenshot")</a>

If you don't see any assigned interfaces above the console menu or if you're having problems connection to the WebGUI I recommend that you first check that you're using the correct port. Second choose the Assign Interfaces option in the console menu and follow the guidelines. Third choose the Set interface(s) IP address option in the console menu and follow the guidelines.

## General setup wizard
Open a web browser and navigate to https://&lt;your lan ip&gt;, using the default username *admin* and password *pfsense* to login. The first time you access the pfSense WebGUI you'll need to change the default admin password and so some general setup.

### 1. General Information
These settings are quite self-explanatory. The hostname and domain are primarily for locating your firewall/router by DNS on your local network(s), LANs. As you can see on the screenshot below I'm using [Google Public DNS](https://developers.google.com/speed/public-dns/) as primary and secondary DNS servers. In general third-party DNS servers may be faster and more reliable than the DNS servers provided by your Internet Service Provider (ISP). I'll recommend that you use something like [namebench](https://code.google.com/archive/p/namebench/) to find the fastest DNS servers for your scenario.

<a href="/public/uploads/pfsense-wizard-general-information.png"><img src="/public/uploads/pfsense-wizard-general-information.png" alt="pfSense setup wizard, general information screenshot" title="pfSense setup wizard, general information screenshot"  /></a>

### 2. Time Server Information
Here you provide time servers and timezone. For the time server hostname you provide a list of servers (space separated) to use for NTP (time synchronization). The use of NTP pool servers is recommended, such as 0.pfsense.pool.ntp.org 1.pfsense.pool.ntp.org and so on. Have a look at [NTP Pool Project](http://www.pool.ntp.org/) for more information.

<a href="/public/uploads/pfsense-wizard-time-server-info.png"><img src="/public/uploads/pfsense-wizard-time-server-info.png" alt="pfSense setup wizard, time server information screenshot" title="pfSense setup wizard, time server information screenshot" /></a>

### 3. Configure WAN Interface
For the WAN interface configuration you need to provide your configuration based on your ISP requirements. My ISP using DHCP so I'll choose that type. Here you can spoof the MAC address of your WAN interface. That may come in handy when your switching from a router provided by your ISP to your own since it can take a while (hours) for the ISP to accept a new MAC address and assign an IP address for your WAN interface.

I'll leave everything else as default except the last two checkboxes, Block RFC1918 Private Networks and Block bogon networks, which I check. It's a good practice to check these for your WAN interface.

<a href="/public/uploads/pfsense-wizard-configure-wan-interface.png"><img src="/public/uploads/pfsense-wizard-configure-wan-interface.png" alt="pfSense setup wizard, configure WAN interface screenshot" title="pfSense setup wizard, configure WAN interface screenshot" /></a>

<a href="/public/uploads/pfsense-wizard-configure-wan-interface-2.png"><img src="/public/uploads/pfsense-wizard-configure-wan-interface-2.png" alt="pfSense setup wizard, configure WAN interface 2 screenshot" title="pfSense setup wizard, configure WAN interface 2 screenshot" /></a>

<a href="/public/uploads/pfsense-wizard-configure-wan-interface-3.png"><img src="/public/uploads/pfsense-wizard-configure-wan-interface-3.png" alt="pfSense setup wizard, configure WAN interface 3 screenshot" title="pfSense setup wizard, configure WAN interface 3 screenshot" /></a>

### 4. Configure LAN Interface
Set the LAN IP address, this address/network will be used to access the router/firewall. Here you should select a [Private Network address space](https://en.wikipedia.org/wiki/Private_network) and you should use one of 10.0.0.0, 172.16.0.0 or 192.168.0.0 for your LAN network(s). I choose to use addresses in the 10.0.0.0 space. The default LAN IP address are 192.168.1.1 with subnet mask 24.

<a href="/public/uploads/pfsense-wizard-configure-lan-interface.png"><img src="/public/uploads/pfsense-wizard-configure-lan-interface.png" alt="pfSense setup wizard, configure LAN interface screenshot" title="pfSense setup wizard, configure LAN interface screenshot" /></a>

### 5. Set Admin WebGUI Password
Change the default password since it will be used for accessing the admin WebGUI and SSH (if enabled).

<a href="/public/uploads/pfsense-wizard-admin-password.png"><img src="/public/uploads/pfsense-wizard-admin-password.png" alt="pfSense setup wizard, set admin WebGUI password screenshot" title="pfSense setup wizard, set admin WebGUI password screenshot" /></a>

## Conclusion
This concludes the second part. In the next post I'll show how I enabled wireless capabilities in my pfSense firewall/router.

### Related articles

<ul class="related-posts">
  {% for post in site.categories.diy reversed %}
    {% if post.url != page.url %}
        <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>
