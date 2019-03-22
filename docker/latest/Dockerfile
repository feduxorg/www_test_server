FROM golang:1.11 as generator

# Set up environment
RUN go get -u github.com/subfuzion/envtpl/...

# Install file generator
RUN install -m 0755 -D $GOPATH/bin/envtpl /usr/local/bin/envtpl

######
FROM ruby:2.6 as base

RUN apt-get update -y \
      && apt-get install -y memcached libmemcached-tools dumb-init libssl1.1 libpq5 ncdu postgresql-client-common

# Testing repository - main, contrib and non-free branches
RUN echo deb http://http.us.debian.org/debian testing main non-free contrib >> /etc/apt/sources.list
RUN echo deb http://security.debian.org/ testing/updates main contrib non-free >> /etc/apt/sources.list

# Add packages
RUN apt-get update -y \
      && apt-get install -y -t testing libsqlite3-0 \
      && apt-get install -y -t testing file

# Clean up
RUN apt-get autoclean \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

######

FROM base as build

ENV DOCKER_BUILD "1"
ARG RAILS_ENV=production
ENV RAILS_ENV="${RAILS_ENV}"
ENV RACK_HOST="0.0.0.0"
ENV RACK_PORT=3000
ENV DEFAULT_MAIL_URL_HOST "http://localhost:3000"
ENV DATABASE_URL "sqlite3:/db/${RAILS_ENV}.sqlite3?timeout=10000"

VOLUME ["/db"]

ADD bin /srv/app/bin/
ADD env.sh /srv/app/
WORKDIR /srv/app

# Install missing development packages
# to make gems build
RUN apt-get update -y \
      && apt-get install -y libsqlite3-dev libssl-dev libpq-dev \
      && apt-get install -y -t testing libmagic-dev

# Install gems
ADD src/Gemfile /srv/app/Gemfile
ADD src/Gemfile.lock /srv/app/Gemfile.lock

# Configure working directory
WORKDIR /srv/app

# Install gems
RUN gem install -v 1.17.3 bundler
RUN bundle config
RUN bundle install --jobs 8
RUN bundle show

# Add app
ADD src/ /srv/app

# Pre-compile assets
# Don't use bin/rails or bundle exec rails for this
# This doesn't work
RUN bin/rails assets:clobber \
    && bin/rails assets:precompile

# Add build file
RUN echo "Build on $(date '+%Y-%m-%d %H:%M:%S')" > /release.txt \
  && echo -n "App Version: " >> /release.txt

##########

FROM base
MAINTAINER dev@fedux.org

ENV DOCKER_BUILD "1"
ARG RAILS_ENV=production
ENV RAILS_ENV="${RAILS_ENV}"
ENV RACK_HOST="0.0.0.0"
ENV RACK_PORT=3000
ENV DEFAULT_MAIL_URL_HOST "http://localhost:3000"
ENV DATABASE_URL "sqlite3:db/${RAILS_ENV}.sqlite3?timeout=10000"
ENV LOGIN_VIA_SSL "true"

# Install clamAV
RUN apt-get update -y \
  && apt-get install -y clamav clamav-base clamav-freshclam clamav-unofficial-sigs clamav-daemon

# Setup clamav
RUN install -d /etc/clamd.d \
  && sed -i 's/^#User/User/' /etc/clamav/clamd.conf \
  && sed -i 's/^LocalSocket/#LocalSocket/' /etc/clamav/clamd.conf \
  && sed -i '/LocalSocketMode/a TCPSocket 3310' /etc/clamav/clamd.conf \
  && sed -i '/LocalSocketMode/a TCPAddr 127.0.0.1' /etc/clamav/clamd.conf \
  && sed -i '/^DetectBrokenExecutables/d' /etc/clamav/clamd.conf

# Clean up install
RUN apt-get autoclean -y \
  && apt-get clean -y \
  && apt-get autoremove -y  \
  && rm -rf /var/lib/apt/lists/*

# Copy from build
COPY --from=build /srv/app /srv/app
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /release.txt /release.txt
COPY --from=generator /usr/local/bin/envtpl /usr/local/bin/envtpl

# Add freshclam configuration file
ADD docker/latest/freshclam.conf.tpl /etc/clamav/freshclam.conf.tpl

# Export things
EXPOSE 3000

# Working directory for app
WORKDIR /srv/app

# Wait helper
ADD src/script/wait-for-it /usr/local/bin/wait-for-it
RUN chmod +x /usr/local/bin/wait-for-it

# Add application help
ADD src/script/app-help /usr/local/bin/app-help
RUN chmod +x /usr/local/bin/app-help

# Make foreman happy
# and start without any set env var
# by .env*
RUN touch /tmp/.env-intentionally-left-blank

# Set entrypoint for image/container
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["ruby", "/srv/app/Init"]
