# Webserver to test HTTP proxies

## Build image

~~~bash
bin/docker/build
~~~

## Download images

~~~bash
docker pull feduxorg/www_test_server
~~~

## Run image

Make sure no other server process is bound to port 3000 locally.

~~~bash
docker run \
  --name www_test_server-1 \
  --rm \
  -p 3000:3000 \
  feduxorg/www_test_server
~~~

## Pre-seeding

The image includes a script `/srv/app/Init` which sets up the
roles `admin`, `user` and `guest`. It also creates a user called
`admin@example.org` with password `*Test123`. After creating another
`admin`-user you can safely remove the bootstrapped admin user.

~~~
docker exec -it www_test_server-1 bash
rake db:seed
~~~

## Database

If you want to run another database than SQlite you need to pass the
`DATABASE_URL`-environment variable to the container. 

~~~
# SQLite
DATABASE_URL="sqlite3:db/development.sqlite3"

# mind the / at the very beginning of the path
DATABASE_URL="sqlite3:/db/production.sqlite3"

# Postgres
# Make sure your hostname does not include "underscores"
# this does not work with the default URL library used by ruby
DATABASE_URL="postgresql://user:password@host/database?pool=5&encoding=unicode"
~~~

*Run the container*

~~~
docker run \
  --name www_test_server-1 \
  -e DATABASE_URL="postgresql://user:password@host/database?pool=5&encoding=unicode" \
  --rm \
  -ti \
  -p 3000:3000 \
  feduxorg/centos-www_test_server
~~~

## Authentication and Authorization

All users and (hashed) passwords are stored in the same database "Rails" uses.
Users can use most features of the web application. But only administrators
are able to:

* Create new and modify existing users
* Upload new/Change existing/Delete existing files

After adding a user you need to approve it. Otherwise the user cannot sign in.

## Modify image

### Modify Domain for registering users

You need to replace `config.action_mailer.default_url_options` with an
appropriate value for your environment in
`app/config/environments/production.rb`. By default it's `{ host: 'localhost',
port: 3000 }`.
