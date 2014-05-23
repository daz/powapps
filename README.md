# Pow Apps

A page with links to all your [Pow](http://pow.cx) apps.

![Pow Apps](http://daz.github.com/powapps/images/screenshots.png)

Links are relative to the current domain, so you can get quick access to apps on a network device if you're using [xip.io](http://xip.io)

## Use

Jump on your iPhone, iPad, or virtual machine and go to `http://powapps.10.0.0.1.xip.io` (sub in the IP to your host's IP), or use locally at `http://powapps.dev/`

Add to your iOS home screen, or bookmark!

## Installation

No dependencies. Just clone into `~/.pow`

```sh
$ cd ~/.pow
$ git clone https://github.com/daz/powapps.git
```

(Optional) Running this on your host machine will print the Pow Apps xip.io address

```sh
$ ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print "http://powapps."$2".xip.io"}'
```
