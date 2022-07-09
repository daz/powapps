# Pow Apps

A page with links to all your [Puma-dev](https://github.com/puma/puma-dev) apps.

Links are relative to the current domain, so you can get quick access to apps on a network device if you're using a wildcard DNS like [nip.io](https://nip.io/)

## Use

Jump on your iPhone, iPad, or virtual machine and go to `http://powapps.10.0.0.1.nip.io` (sub in the IP to your host's IP), or use locally at `http://powapps.test/`

Add to your iOS home screen, or bookmark!

## Installation

Just clone directly into `~/.puma-dev`

```sh
$ cd ~/.puma-dev
$ git clone https://github.com/daz/powapps.git
```

(Optional) Running this on your host machine will print the Pow Apps nip.io address:

```sh
$ ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print "http://powapps."$2".nip.io"}'
```

## Dependencies

Compatible with Ruby >= 1.8.7 and Rack is required.
