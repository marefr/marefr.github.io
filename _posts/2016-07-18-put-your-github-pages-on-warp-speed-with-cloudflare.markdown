---
title: Put your GitHub pages on warp speed with CloudFlare
published: true
summary: "By using a custom domain for your GitHub page you can utilize CloudFlare to make your site secure and faster for your visitors, for free. I will also show you some more features that CloudFlare has to offer."
categories: [ "hosting" ]
tags: [ "CloudFlare", "GitHub", "Security" ]
image:
  thumbnail:
    src: /public/uploads/cloudflare-logo-thumb.png
    alt: Cloudflare logo
  large:
    src: /public/uploads/cloudflare-logo-large.png
    alt: Cloudflare logo
sitemap:
  lastmod: 2016-07-18 19:00
---

By using a custom domain for your GitHub page you can utilize [CloudFlare](https://www.cloudflare.com) to make your site secure and faster for your visitors, for free. I will also show you some more features that CloudFlare has to offer.

<!-- more -->

[CloudFlare](https://www.cloudflare.com) has already written an excellent post on their blog on how to use GitHub and CloudFlare together to enable SSL/HTTPS and strict caching of static content, see [Secure and fast GitHub Pages with CloudFlare](https://blog.cloudflare.com/secure-and-fast-github-pages-with-cloudflare/).

However, CloudFlare has more to offer than just SSL/HTTPS and strict caching. Below are some examples.

## Auto minify static content
If your lazy as I am Cloudflare can automatically minify all your hosted static content such as HTML, JavaScript and CSS. Just go to the speed tab and check the options you would like to be automatically minified. This way you don't need to setup Grunt/Gulp for your personal website and you can focus on coding and drinking beer instead.

![CloudFlare auto minify screenshot](/public/uploads/cloudflare-minify.png "CloudFlare auto minify screenshot")

## Rocker Loader
This feature improves load time for pages that include JavaScript. It decreases the number of network requests by bundling JavaScript files, even third party resources, to avoid slowing down page rendering. You find this feature under the speed tab. This feature is still in BETA, but it works good for me.

![CloudFlare Rocket Loader screenshot](/public/uploads/cloudflare-rocket-loader.png "CloudFlare Rocket Loader screenshot")

## Domain Name System (DNS)
CloudFlare gives you a complete Domain Name System for free which I find very convenient. I mainly use it for subdomains besides hosting this site. It allows you to use A, AAAA, CNAME, MX, LOC, SRV, SPF, TXT and NS records to suit your needs.

I had to setup a wildcard subdomain pointing to one of my networks which had a dynamic IP address. The issue was that my dynamic dns updater only allowed to update an A record in the DNS and not any CNAME records.

I solved this by creating an A record, i.e. subdomain.marcus-e.se, that pointed to my network IP address and then creating a wildcard CNAME record, i.e. *.subdomain.marcus-e.se, that pointed to my A record (subdomain.marcus-e.se). With this I can let my dynamic dns updater update the A record and I'll still be able to access everything under *.subdomain.marcus-e.se.

![CloudFlare DNS screenshot](/public/uploads/cloudflare-dns.png "CloudFlare DNS screenshot")

## Conclusion
CloudFlare gives you a lot of security and speed for your visitors for free and makes your life easier. I highly recommend it. Please inspect this site using Chrome dev tools or similar and have a look what CloudFlare has given my site in comparison with [the source code](https://github.com/marefr/marefr.github.io).