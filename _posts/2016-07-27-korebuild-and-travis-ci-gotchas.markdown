---
title: KoreBuild and Travis CI Gotchas
published: true
summary: "In this post I will show you how I got KoreBuild to work on Travis CI for building and testing your .NET Core projects in a Linux and Mac environment."
categories: [ "Development" ]
tags: [ ".NET Core", "Travis CI", "KoreBuild" ]
image:
  thumbnail:
    src:
    alt:
  large:
    src:
    alt:
sitemap:
  lastmod: 2016-07-27 23:30
---

In this post I will show you how I got KoreBuild to work on [Travis CI](https://travis-ci.org/) for building and testing your .NET Core projects in a Linux and Mac environment.

<!-- more -->

Initially I wanted to setup CI for one of my .NET Core projects. I didn't have a clue of how to achieve that so I went for my friend Google and found two awesome posts, [Publishing your first .NET Core NuGet package with AppVeyor and MyGet](http://andrewlock.net/publishing-your-first-nuget-package-with-appveyor-and-myget/) and [Adding Travis CI builds to a .NET Core app](http://andrewlock.net/adding-travis-ci-to-a-net-core-app/). I highly recommend you to read these for details and tips on how to setup your .NET Core project for cross-platform CI and publish of NuGet packages using AppVeyor, MyGet, NuGet and Travis CI.

In the [Adding Travis CI builds to a .NET Core app](http://andrewlock.net/adding-travis-ci-to-a-net-core-app/) post the writer mentions [KoreBuild](https://github.com/aspnet/KoreBuild) as an alternative to implementing your own .NET Core build scripts and I found that a very interesting alternative.

[KoreBuild](https://github.com/aspnet/KoreBuild) is a project which is part of ASP.NET Core and provides build scripts for at least projects in the [aspnet org](https://github.com/aspnet/), but doesn't stop anyone else from using it. I'm guessing that this eventually will be the offical tool of building and testing cross-plattform .NET Core projects, but I may be wrong.

I started with downloading the build files from the [KoreBuild master branch](https://github.com/aspnet/KoreBuild/tree/master/template). Then I created a *.travis.yml* file with the following content:

``` yml
language: csharp
sudo: required
dist: trusty
addons:
  apt:
    packages:
    - gettext
    - libcurl4-openssl-dev
    - libicu-dev
    - libssl-dev
    - libunwind8
    - zlib1g
mono:
  - 4.0.5
os:
  - linux
  - osx
osx_image: xcode7.1
branches:
  only:
    - master
before_install:
  - if test "$TRAVIS_OS_NAME" == "osx"; then brew update; brew install openssl; brew link --force openssl; fi
script:
  - ./build.sh verify
```

I got the content of the *.travis.yml* by looking at one of the [aspnet org](https://github.com/aspnet/) projects and modified it to suit my needs.

After configuration of Travis CI I pushed the build scripts and *.travis.yml* to GitHub. Unfortunately both the Linux and Mac builds failed with the following message:

```
# Travis CI log:
...

The command "./build.sh verify" exited with 126.

# Travis CI Raw log:
...

/home/travis/build.sh: line 45: ./build.sh: Permission denied (Linux)
/Users/travis/build.sh: line 45: ./build.sh: Permission denied (Mac)
```

## Gotcha - You need to make custom scripts executable
Again, my friend Google helped me, but it wasn't that easy to find. Took me quite some time. The solution is that you need to make your custom script executable for Travis CI to work properly. When I found that I also found the following in Travis CI documentation:

> When using custom scripts they should be executable (for example, using chmod +x) and contain a valid shebang line such as /usr/bin/env sh, /usr/bin/env ruby, or /usr/bin/env python.

You can either make a file executable using Git which will result in that the file always will be executable when cloning your Git repository.

```
$ git update-index --chmod=+x build.sh
```

Or you can add the following to your *.travis.yml* which will result in that the file only will be executable for Travis CI, if not modified locally.

``` yaml
before_install:
 - chmod +x build.sh
```

Since it's possible that you or someone else will clone your .NET Core project on a Linux or Mac environment I recommend to use the Git approach which will allow them to use the *build.sh* directly without any chmod changes.
