---
title: 'DIY pfSense Firewall/Router Part 1: Introduction'
published: true
summary: "When i moved to a new appartment some time ago there was already a router installed and provided by my ISP. The router was responsible for routing WAN and IPTV traffic and acted as a Wireless Access Point. However the router was completely locked down and there were no way to access it. I started to look for a replacement and quite soon I found a match made in heaven - pfSense as firewall/router on my own hardware."
categories: [ "diy" ]
tags: [ "pfSense", "firewall", "router" ]
image:
  thumbnail:
    src: /public/uploads/celeron-1037u-mini-desktop-computer-thumb.jpg
    alt: Intel Celeron 1037U Mini Desktop Computer
  large:
    src: /public/uploads/celeron-1037u-mini-desktop-computer-large.jpg
    alt: Intel Celeron 1037U Mini Desktop Computer
sitemap:
  lastmod: 2016-07-19 18:25
---

When i moved to a new appartment some time ago there was already a router installed and provided by my ISP. The router was responsible for routing WAN and IPTV traffic and acted as a Wireless Access Point. However the router was completely locked down and there were no way to access it. I started to look for a replacement and quite soon I found a match made in heaven - pfSense as firewall/router on my own hardware.

<!-- more -->

In this multipart series I will show you how I built and configured my own firewall/router with Wireless capabilities and a lot more using pfSense.

## What is pfSense?
> [pfSense](https://www.pfsense.org/) is an open source firewall/router computer software distribution based on FreeBSD. It is installed on a physical computer or a virtual machine to make a dedicated firewall/router for a network and is noted for its reliability and offering features often only found in expensive commercial firewalls. It can be configured and upgraded through a web-based interface, and requires no knowledge of the underlying FreeBSD system to manage. pfSense is commonly deployed as a perimeter firewall, router, wireless access point, DHCP server, DNS server, and as a VPN endpoint. pfSense supports installation of third-party packages like Snort or Squid through its Package Manager.
> -- <cite>[Wikipedia][1]</cite>

## Hardware
I found an Intel Celeron 1037U Mini Desktop Computer on [AliExpress](http://www.aliexpress.com/item/Free-Shipping-Cost-Celeron-1037U-Mini-Desktop-Computer-PC-2GB-RAM-8GB-SSD-Mini-ITX-Case/1958958173.html?spm=2114.13010608.0.56.GAH3ZF) that suited me perfectly:

* Small form-factor
* Fanless system
* Faily good processor power and speed and enough RAM
* Support for AES-NI for hardware encryption/decryption that can come in handy when using VPN technologies sush as OpenVPN
* Dual Intel Gigabit Ethernet NICs with support for teaming if needed
* Wireless support/dual antenna with extension card
* Cheap, about $184 plus $50 in custom (imported from China to Sweden)

![Intel Celeron 1037U Mini Desktop Computer inside look](/public/uploads/celeron-1037u-mini-desktop-computer-inside.jpg "Intel Celeron 1037U Mini Desktop Computer inside look")
*[Image](http://g03.a.alicdn.com/kf/HTB1dErxGXXXXXcxXVXXq6xXFXXXp/202292472/HTB1dErxGXXXXXcxXVXXq6xXFXXXp.jpg) by [Eglobal Technology Co Ltd](http://www.eglobaltech.cn/)*

### Technical Specification

<table>
    <tbody>
      <tr>
        <td colspan="2"><strong>General</strong></td>
      </tr>
      <tr>
        <td>Processor</td>
        <td>Intel Celeron 1037U 1.8GHz Dual Core 2 thread</td>
      </tr>
      <tr>
        <td>Storage</td>
        <td>SSD 8GB</td>
      </tr>
      <tr>
        <td>RAM</td>
        <td>DDR3 2GB</td>
      </tr>
      <tr>
        <td>Model</td>
        <td>Intel HM77 Express High Speed Chipset</td>
      </tr>
      <tr>
        <td colspan="2"><strong>Processor Details</strong></td>
      </tr>
      <tr>
        <td>CPU</td>
        <td>Intel Celeron 1037U</td>
      </tr>
      <tr>
        <td>Processor number</td>
        <td>2 core / 2 threads</td>
      </tr>
      <tr>
        <td>Technique</td>
        <td>22NM</td>
      </tr>
      <tr>
        <td>Slot</td>
        <td>Socket H2(LGA 1155)</td>
      </tr>
      <tr>
        <td style="vertical-align: top;">Buffer RAM</td>
        <td>
            L1 data cache: 32 KB, 8-Way, 64 byte lines<br/>
            L1 code cache: 32 KB, 8-Way, 64 byte lines<br/>
            L2 cache: 256 KB, 8-Way, 64 byte lines<br/>
            L3 cache: 2 MB, 8-Way, 64 byte lines<br/>
        </td>
      </tr>
      <tr>
        <td>Characteristic</td>
        <td>MMX, SSE, SSE2, SSE3, SSSE3, SSE4.1, SSE4.2, EM64T, EIST</td>
      </tr>
      <tr>
        <td colspan="2"><strong>Display Card Details</strong></td>
      </tr>
      <tr>
        <td>Graphic Cards</td>
        <td>
            INTEL Ivy Bridge Graphics Controller<br/>
            Intel HD Graphics 2500
        </td>
      </tr>
      <tr>
        <td>Resolution (MAX)</td>
        <td>Support 1920*1080 HD resolution, 32 bit color depth 60Hz</td>
      </tr>
      <tr>
        <td>Audio Cards</td>
        <td>Intel(R) display audio Intel Panther Point High Definition</td>
      </tr>
      <tr>
        <td colspan="2"><strong>Network</strong></td>
      </tr>
      <tr>
        <td>Network Card</td>
        <td>Intel 82574L PCI-E Gigabit Ethernet NIC</td>
      </tr>
      <tr>
        <td>Ethernet</td>
        <td>10/100/1000Mbps Adaptive</td>
      </tr>
      <tr>
        <td>WIFI</td>
        <td>802.11.b/g/n(150M or 300M Optional)</td>
      </tr>
      <tr>
        <td colspan="2"><strong>I/O Port</strong></td>
      </tr>
      <tr>
        <td>Display port</td>
        <td>1x VGA+ 1x HDMI</td>
      </tr>
      <tr>
        <td>USB port</td>
        <td>2x USB 2.0 ports; 4x USB 3.0</td>
      </tr>
      <tr>
        <td>Ethernet port</td>
        <td>2x RJ 45 10/100/1000Mbps Adaptive</td>
      </tr>
      <tr>
        <td>Power input port</td>
        <td>1 inner diameter 2.5mm, external diameter 5.5mm</td>
      </tr>
      <tr>
        <td>Audio</td>
        <td>Standard 3.5 Audio input and output</td>
      </tr>
      <tr>
        <td colspan="2"><strong>Power and Working Environment</strong></td>
      </tr>
      <tr>
        <td>Input</td>
        <td>DC100-240V AC/50-60Hz</td>
      </tr>
      <tr>
        <td>Output</td>
        <td>DC 12V/3A</td>
      </tr>
      <tr>
        <td>Type</td>
        <td>External power adapter mode</td>
      </tr>
      <tr>
        <td>Type</td>
        <td>17W</td>
      </tr>
      <tr>
        <td>Noise</td>
        <td>Fanless System</td>
      </tr>
      <tr>
        <td>Temperature</td>
        <td>0-70 Centigrade</td>
      </tr>
      <tr>
        <td>Humidity</td>
        <td>10%-85%</td>
      </tr>
    </tbody>
</table>

## Assembly
Everything arrived pre-assembled. Just needed to plugin the power cord and I was good to go. Really good first time experience of shopping at AliExpress.

![Intel Celeron 1037U Mini Desktop Computer box](/public/uploads/celeron-1037u-mini-desktop-computer-box.jpg "Intel Celeron 1037U Mini Desktop Computer box")
*[Image](http://g03.a.alicdn.com/kf/HTB1qZ4TLVXXXXXbapXXq6xXFXXXs/Barebone-Fanless-Mini-PC-N3150-Barebone-Nettop-PC-No-RAM-No-HDD-SSD-RTL8111DL-RJ45-Lan.jpg) by [Eglobal Technology Co Ltd](http://www.eglobaltech.cn/)*

![Intel Celeron 1037U Mini Desktop Computer parts](/public/uploads/celeron-1037u-mini-desktop-computer-parts.jpg "Intel Celeron 1037U Mini Desktop Computer parts")
*[Image](http://g02.a.alicdn.com/kf/HTB1pF8kIXXXXXa8XpXXq6xXFXXX4/Free-Shipping-Cost-Celeron-1037U-Mini-Desktop-Computer-PC-2GB-RAM-8GB-SSD-Mini-ITX-Case.jpg) by [Eglobal Technology Co Ltd](http://www.eglobaltech.cn/)*

This concludes the first part. In the next post I'll show how to install pfSense and do some general setup.

[1]:https://en.wikipedia.org/wiki/PfSense
