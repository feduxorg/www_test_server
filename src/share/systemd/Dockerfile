FROM feduxorg/centos-rails:latest
MAINTAINER fedux.org

# ENV http_proxy http://172.17.42.1:3128
# ENV https_proxy https://172.17.42.1:3128

# Make the gems compile - missing files/symlinks
ADD magic.h /usr/include/
RUN ln -s libmagic.so.1.0.0 /usr/lib64/libmagic.so

# Make the gems compile - missing headers
RUN yum install -y zlib-devel patch openssl-devel sqlite-devel gcc-c++

# Copy app
RUN install -d /srv/app/
RUN curl -L https://github.com/fedux-org/test_server/archive/master.tar.gz | tar -xzf - -C /srv/app/ --strip-components=1
WORKDIR /srv/app

# Install gems
RUN bundle install

# Pre-compile assets
RUN bundle exec rake assets:precompile
