---
title: Russian dolls in software development
layout: post
tags: 
- diary
---
It's been some time since I last posted. Five days a week, I spend 09:00-17:30 working on the next release of my employer's closed-source product, with a two hour commute each way. Add to that the time taken to eat, sleep and keep up with the rest of my life and you leave very little time except some sliver of evenings and weekends for anything else. <!-- more -->When it comes to software, I struggle to come up with ideas for something interesting and useful that hasn't already been done to death. 

Occasionally I get a flash of an idea. This would be great if not for the fact that the next thing to inevitably happen is that I then get mired in a swamp of tangential decisions and "best practice".  Want to work with Ruby? Great! First, you should set up a [Virtualbox][virtualbox] VM for your development. No, scratch that, you should use [Vagrant][vagrant]! Maybe if you're lucky, there's a [pre-prepared box][vagrantboxes] you can use. Ah wait, now [Docker][docker] is all the rage, use that instead. It's [so much better][docker-speed]! But remember, if you're on a Mac, don't use the tiny Docker shim-vm installed by default, because there are [problems][docker-problems] [with it][docker-problems-two] (hopefully you found this out before you ran into one of them.) You have to [set up your own VM][docker-on-osx] if you want to use Docker on OS X.

Okay, you got that sorted? Now install Ruby. And no, you [can't][ruby-the-correct-way] just `apt-get install ruby`, you need to use `rvm` or `rbenv` to keep things clean, and you need to handle gem dependencies too. Make sure to use `bundler` for that. You'll need to install a package manager for OS X to use most of these third-party tools and keep things clean, so go get [Homebrew][homebrew] before you do anything else, then use it to install everything - but don't forget you'll need the [XCode CLI tools][xcode] (a rather large download in itself) before anything will work. Oh, you already installed some of this stuff outside of Homebrew's environment? Oh well, messy OS for you! Don't forget that you set it up this way, or you'll make your system messy at some unforseeable point in the future, and break the sandboxing that this stuff made *super easy* for you. 

*sigh*. 

<iframe src="http://gfycat.com/ifr/WeepyHappyChicken" frameborder="0" scrolling="no" width="480" height="360" style="-webkit-backface-visibility: hidden;-webkit-transform: scale(1);" ></iframe>

Maybe, when I've discovered a way to build an isolated, clean development environment that doesn't drive me insane, I'll get to writing something useful.

One day.

[virtualbox]: http://www.virtualbox.com
[vagrant]: http://www.vagrantup.com
[vagrantboxes]: http://www.vagrantbox.es
[docker]: https://docker.com
[docker-speed]: http://www.youtube.com/watch?v=Q5POuMHxW-0
[docker-problems]: http://serverascode.com/2014/03/26/boot2docker.html
[docker-problems-two]: https://github.com/boot2docker/boot2docker/issues/392
[docker-on-osx]: http://maori.geek.nz/post/vagrant_with_docker_how_to_set_up_postgres_elasticsearch_and_redis_on_mac_os_x
[ruby-the-correct-way]: http://cbednarski.com/articles/installing-ruby/
[homebrew]: http://brew.sh
[xcode]: http://railsapps.github.io/xcode-command-line-tools.html