---
title: 'Software Localization Part 1: Introduction'
published: True
summary: "In this multipart series I will discuss the challenges, difficulties and different strategies of adapting multi-language support in software, mainly targeting an existing product built on the .NET platform. In this first part there will be an introduction to the basic concepts of software localization."
categories: ["Localization"]
tags: ["i18n", "L10n", ".NET", "Internationalization", "Localization"]
sitemap:
  lastmod: 2014-09-29 16:29
---

In this multipart series I will discuss the challenges, difficulties and different strategies of adapting multi-language support in software,
mainly targeting an existing product built on the .NET platform. In this first part there will be an introduction to the basic concepts of
software localization.

<!-- more -->

If you're working as a software developer for a mid-size/enterprise product you will most certainly experience that your manager someday rushes in
to your room explaining that the product must be translated to some other language or languages.

As the software developer your first thought may be something like:
>OMG this is impossible! How are we gonna accomplish this with all of our freaking spagetti and legacy code?

But before even thinking about possible problems it's vital to understand what your manager or customer actually want,
i.e. what are the requirements and why are we doing this. This shouldn't come as a surprise since you're probably already
thinking in these terms in your day to day business.

To be able to understand what your manager or customers want you need to ask the right questions. If you have no experience of
software localization it will be hard to ask the right questions so let's start with some basic concepts before we proceed with
some discussions about requirements and scope.

## Internationalization and localization
> In computing, internationalization and localization are means of adapting computer software to different languages, regional
> differences and technical requirements of a target market.<br/>
> - <cite>[Wikipedia][1]</cite>

Translating a software product is a two-step process consisting of internationalization (i18n) and localization (L10n). Since software
continuously change, this process will repeat itself forever or until you stop making changes to your software.

Internationalization (i18n, 18 characters between i and n) is the first part of the two-step process and this is a developer task.
Here you write the infrastructure code that will be the core functionality for enabling your application to support various languages,
regions, date and number formats etc. In the best of worlds you should be able to write the infrastructure code ones, verify that it
functions as expected and basically forget about it. I strongly recommend that you put some extra effort here since it will pay off
in the long run.

On top of this you will use the infrastructure to mark and collect all the strings in your application that needs
to be translated. This will be a continuous task until you stop making any changes to your software. That's why it's very important that
the provided infrastructure help streamline the process and support the developers daily work, otherwise it will be a costly operation and
developers will not be satisfied.

Localization (L10n, 10 characters between L and n) is the second part of the two-step process and this is where the actual translations to other
languages and regions are made. Often you initially create one or a few language translations and later on decide to create some more.

## Requirements and scope
As a first step I strongly suggest that you start with identifying all different parts in or around your application that may need
translation. For example

* Front-end
    * Static resources
        * HTML
        * JavaScript
        * Templates, e.g. Handlebars.js or similar
        * Images
        * Documents
    * Dynamic resources
        * ASP.NET MVC Razor views / partials
        * ASP.NET Web Forms pages / components
    * Code
        * ASP.NET MVC controllers
        * ASP.NET Web Forms code-behind files
* Back-end
    * Application emails
    * Audit logs
    * Persistence
* Business Intelligence/Reporting
* Product documentation
* Product marketing website
* Support channels

As you see above there can be more parts or different types to translate than you first thought right? Having a list like above could
be a very valuable tool to have when you're discussing the requirements and scope of software localization for the first times with
your manager or customer.

Software localization projects intend to be large, counting in resource utilization, time and costs. If your planning to start such a
project with the plan to cover a new market/region I strongly suggest that you start as small as you can. Maybe it's enough to start
translating only the product marketing website and/or the most important feature in your application. By starting small you can
take measures and hopefully get important information about if this is the right direction to go taking possible revenue and estimated
development costs into account.

This ends the first part of my multipart series on software localization. In the next part we'll take a closer look at software
localization on the .NET platform and see what other options there may be besides utilizing the built-in features in the .NET framework.

[1]:http://en.wikipedia.org/wiki/Internationalization_and_localization