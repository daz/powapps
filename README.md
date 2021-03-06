# Pow Apps

A page with links to all your [Pow](http://pow.cx) apps.

![Pow Apps](http://daz.github.com/powapps/images/screenshots.png)

Links are relative to the current domain, so you can get quick access to apps on a network device if you're using [xip.io](http://xip.io)

## Use

Jump on your iPhone, iPad, or virtual machine and go to `http://powapps.10.0.0.1.xip.io` (sub in the IP to your host's IP), or use locally at `http://powapps.dev/`

Add to your iOS home screen, or bookmark!

## Installation

Just clone into `~/.pow`

Compatible with Ruby >= 1.8.7 and Rack is required.

```sh
$ cd ~/.pow
$ git clone https://github.com/daz/powapps.git
```

If you're using [puma-dev](https://github.com/puma/puma-dev), clone into `~/.puma-dev` and edit this line in `lib/powapps.rb`:

```ruby
APPS_DIR = [ ENV['HOME'], '.puma-dev' ]
```

(Optional) Running this on your host machine will print the Pow Apps xip.io address

```sh
$ ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print "http://powapps."$2".xip.io"}'
```
