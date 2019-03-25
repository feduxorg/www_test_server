# TestServer - the endpoint for your proxy server tests

[![Build Status](https://travis-ci.org/fedux-org/test_server.png?branch=master)](https://travis-ci.org/fedux-org/test_server)
[![Code Climate](https://codeclimate.com/github/fedux-org/test_server.png)](https://codeclimate.com/github/fedux-org/test_server)
[![Coverage Status](https://coveralls.io/repos/fedux-org/test_server/badge.png?branch=master)](https://coveralls.io/r/fedux-org/test_server?branch=master)
[![Docker Image](https://img.shields.io/badge/docker-image-blue.svg)](https://registry.hub.docker.com/u/feduxorg/test-server/)


`test_server` *serves two main purposes:*

* end point for your proxy tests.
* load generator via simple website driven by javascript

*Behind the scenes it mainly uses ...*

* [jquery](http://jquery.com/)
* [rails](http://rubyonrails.org/)
* and other wonderful gems 

*Possible use cases:*

* Provide static data via web application to make your tests reliable 
* Generate load via browsers typically used by your users

### Git

*Clone*

```bash
git clone https://github.com/fedux-org/www_test_server
```

*Run*

```bash
key=$(head -c 1M < /dev/urandom |sha256sum)
SECRET_KEY_BASE=$key RAILS_ENV=production rails s --port 8083
```

### Required libraries and external programs

* File Type detection

  You need to install `libmagic` for filetype detection. This library uses the
  same database as the linux `file`-command. The source for that library can be
  found at `http://www.darwinsys.com/file/`.

  On `Arch Linux` and `Debian` you need to install the `file`-package and the
  `dev`-packages. On `Red Hat` make sure the `file-devel`-package is installed.

* Virus detection

  You need to install `clamav` for virus detection. Make sure the clamav-daemon
  is running (`clamd`) and has fresh virus patterns.

  If you're going to use the docker image, make sure `CLAMAV_CLAMD_TCP_ADDRESS`
  (default: `clamav-1`) points to the correct host/container running `clamd`.

### Firewall rules

Following you can find an example configuration for iptables to secure your server. It
opens ports only for your proxy servers to access `test_server`.

```bash
# default policies
iptables -P INPUT -j DROP
iptables -P FORWARD -j DROP
iptables -P OUTPUT -j ACCEPT

# user defined chains
iptables -N TCP
iptables -N UDP

# rules
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -j TCP
iptables -A INPUT -p tcp -m recent --set --name TCP-PORTSCAN --mask 255.255.255.255 --rsource -j REJECT --reject-with tcp-reset
iptables -A INPUT -p udp -m recent --set --name UDP-PORTSCAN --mask 255.255.255.255 --rsource -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable
iptables -A TCP -p tcp -m recent --update --seconds 60 --name TCP-PORTSCAN --mask 255.255.255.255 --rsource -j REJECT --reject-with tcp-reset
iptables -A TCP -s <public ips proxies> -p tcp -m tcp --dport 8083 -j ACCEPT
iptables -A UDP -p udp -m recent --update --seconds 60 --name UDP-PORTSCAN --mask 255.255.255.255 --rsource -j REJECT --reject-with icmp-port-unreachable
COMMIT
```

## Screenshots

To be defined...

## Usage

*Starting Web Application*

Use the techniques given above.

*Load testing*

Point your browser to `http://<your-domain.org>/generator/xhr`.
Fill out the form and run test.

*Testing your proxies*

* Write tests using `capybara` + `rspec`.

or

* Use [`proxy_tester`](https://github.com/fedux-org/proxy_tester) for a fully
  featured solution for writing proxy tests (**RECOMMENDED**). `proxy_tester` uses
  `capybara` and `rspec`, but provides lots of helpers for writing proxy tests
  to reduce the work on your site.

## List of test end points

Just point your browser to the root page `http://<your-server>:8083/`. The
dashboard will provide you a list of available end points for your tests.

## Authentication and Authorization

If you want t


## Contributing

1. Fork it ( http://github.com/<my-github-username>/test_server/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
