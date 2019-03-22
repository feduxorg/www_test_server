FROM feduxorg/centos-rails
MAINTAINER fedux.org

#ENV http_proxy http://172.17.42.1:3128
#ENV https_proxy https://172.17.42.1:3128

ENV RAILS_ENV production
EXPOSE 80

VOLUME /opt/test_server/log/
VOLUME /opt/test_server/tmp/

RUN yum install -y file-libs

RUN mkdir -p /opt/test_server/
ADD . /opt/test_server/

WORKDIR /opt/test_server

RUN bundle install
RUN bundle exec rake assets:precompile

CMD ["/opt/test_server/bin/test_server.sh"]
