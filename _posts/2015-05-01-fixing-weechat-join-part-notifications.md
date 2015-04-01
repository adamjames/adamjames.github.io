---
title: Fixing WeeChat's JOIN/PART notifications
layout: post
tags:
- development
- weechat
- python
---

[WeeChat][weechat] is a brilliant console-based IRC client. It's like a more modern [irssi][irssi], configured with a nice interface and some great features "out of the box". It's also pretty [configurable][weechat-screenshots]:

<a href="{{ site.url }}/_images/weechat-screenshots.png"><img src="{{ site.url }}/_images/weechat-screenshots.png" width="800" height="618"></img></a>

One pet niggle of mine has always been WeeChat's handling of JOIN/PART messages. If you're in a large/busy channel, it can be distracting to constantly see JOIN/PART messages from users who are not actively talking - but switching them off entirely removes some useful conversational context.

I was planning on writing a plugin to fix this, but thankfully I found a satisfactory solution to the problem [already existed][smartfilter], which will selectively filter JOIN/PART notifications. To enable it, use following commands:
```
/set irc.look.smart_filter on
/filter add irc_smart * irc_smart_filter *
```

Adjust the filter delay with `/set irc.look.smart_filter_delay n`, where `n` is an integer. For example, ` /set irc.look.smart_filter_delay 5`. JOIN/PART notifications will be shown for users that spoke within the past *n* minutes.

[weechat]: http://weechat.org/
[irssi]: http://www.irssi.org/
[weechat-screenshots]: http://weechat.org/about/screenshots/

[smartfilter]: http://dev.weechat.org/post/2008/10/25/Smart-IRC-join-part-quit-message-filter