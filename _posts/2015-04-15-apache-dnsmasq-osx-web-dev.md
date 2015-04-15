---
title: Setting up OS X Yosemite for web development with Apache & Dnsmasq
layout: post
tags:
- osx
- webdev
---

I had a couple of issues getting this properly configured, so I thought I'd note down what worked for me. Credit for the content in this post mostly goes to [Chris Mallinson](https://mallinson.ca/osx-web-development/) and [Thomas Sutton](http://passingcuriosity.com/2013/dnsmasq-dev-osx/).

You'll need to download and install XCode and launch it at least once. Accept the licence agreement.
{% highlight console %}
# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Update your homebrew installation
brew up
# Install dnsmasq
brew install dnsmasq
# Copy the default configuration file.
cp $(brew list dnsmasq | grep /dnsmasq.conf.example$) /usr/local/etc/dnsmasq.conf
# Copy the daemon configuration file into place.
sudo cp $(brew list dnsmasq | grep /homebrew.mxcl.dnsmasq.plist$) /Library/LaunchDaemons/
# Start Dnsmasq automatically.
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
{% endhighlight%}
Now, edit `/usr/local/etc/dnsmasq.conf` to tell dnqmasq to answer any request for a `.dev` domain with the address `127.0.0.1`.
<br><img src="{{ site.postimagesurl }}dnsmasq-conf.png"></img><br>
Restart dnsmasq to ensure it picks up the changes, then request a `.dev` domain with `dig` to check you get the answer you want:
{% highlight console %}
sudo launchctl stop homebrew.mxcl.dnsmasq
sudo launchctl start homebrew.mxcl.dnsmasq
dig test.dev @127.0.0.1

; <<>> DiG 9.8.3-P1 <<>> test.dev @127.0.0.1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 23555
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;test.dev.			IN	A

;; ANSWER SECTION:
test.dev.		0	IN	A	127.0.0.1

;; Query time: 0 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Wed Apr 15 23:59:41 2015
;; MSG SIZE  rcvd: 42
{% endhighlight %}
Now we need to configure OS X to use the local dnsmasq server. Create a file for each TLD you want to use under `/etc/resolver` with the same name as the TLD:
{% highlight console %}
sudo mkdir -p /etc/resolver
sudo touch /etc/resolver/dev
sudo nano /etc/resolver/dev
{% endhighlight %}
Enter `nameserver 127.0.0.1` and then save/close the file. This tells OS X to use `127.0.0.1` as the nameserver for all domains under that TLD, instead of searching the public DNS servers for it. Now test that it works:
{% highlight console %}
# Make sure DNS still works.
ping -c 1 www.google.com
# Check that .dev names work
ping -c 1 this.is.a.test.dev
ping -c 1 iam.the.walrus.dev
{% endhighlight %}
Now we need to configure Apache to serve up domains we want to use for development. The instructions below are for OS X 10.7 onwards.
Start apache and check that it works with `sudo apachectl start`. If you don't get any errors, browse to localhost. You should see an "It works!" screen. Open `/private/etc/apache2/httpd.conf` and continue.
1. Activate mod_vhost_alias around line 160: `#LoadModule vhost_alias_module libexec/apache2/mod_vhost_alias.so`
2. On or around line 169, uncomment `#LoadModule php5_module libexec/apache2/libphp5.so` if you want to use PHP.
3. Comment out (using #) or reconfigure the following section around line 220 to allow apache access to the filesystem folder you want to store sites in:

```
<Directory />
    AllowOverride none
    Require all denied
</Directory> 
```

4. Around line 500, enable vhosts: `#Include /private/etc/apache2/extra/httpd-vhosts.conf`.
5. Open `\private\etc\apache2\extra\httpd-vhosts.conf` and enter the following, replacing `/Users/adam/Sites` with your desired root folder:

```
<Directory "/Users/adam/Sites">
  Options Indexes MultiViews FollowSymLinks
  AllowOverride All
  Order allow,deny
  Allow from all
</Directory>

# You may be able to remove wwwroot if you just want files in .../Sites/<sitename>.

<Virtualhost *:80>
  VirtualDocumentRoot "/Users/adam/Sites/%1/wwwroot"
  ServerName sites.dev
  ServerAlias *.dev
  UseCanonicalName Off
</Virtualhost>
```

Now you should be able to visit *yourdevelopmentwebsite.dev* in a browser, with the files stored in e.g. */Users/adam/Sites/yourdevelopmentwebsite/wwwroot*.
