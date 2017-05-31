# Hydra-in-a-Box Repository App

Codename: Hyku

## Running the stack

### UC Davis

``` bash
dc --file=dev.yml exec solr solr create -c hydra_development -d
/app/solr/config
dc -f dev.yml exec web bundle exec rails db:migrate
```

After that, we need to go in and create some adminstrative workflows


### For development

```bash
solr_wrapper
fcrepo_wrapper
postgres -D ./db/postgres
redis-server /usr/local/etc/redis.conf
bin/setup
DISABLE_REDIS_CLUSTER=true bundle exec sidekiq
DISABLE_REDIS_CLUSTER=true bundle exec rails server -b 0.0.0.0
```
### For testing

See the [Hyku Development Guide](https://github.com/projecthydra-labs/hyku/wiki/Hyku-Development-Guide) for how to run tests.

### Working with Translations

You can log all of the I18n lookups to the Rails logger by setting the I18N_DEBUG environment variable to true. This will add a lot of chatter to the Rails logger (but can be very helpful to zero in on what I18n key you should or could use).

```console
$ I18N_DEBUG=true bin/rails server
```

### On AWS

AWS CloudFormation templates for the Hyku stack are available in a separate repository:

https://github.com/hybox/aws

### With Docker

We distribute a `docker-compose.yml` configuration for running the Hyku stack and application using docker. Once you have [docker](https://docker.com) installed and running, launch the stack using e.g.:

```bash
docker-compose up -d
```

## Switching accounts

The recommend way to switch your current session from one account to another is by doing:

```ruby
AccountElevator.switch!('repo.example.com')
```

## Development Dependencies

### Postgres

Hydra-in-a-Box supports multitenancy using the `apartment` gem. `apartment` works best with a postgres database.

## Importing
### from CSV:

```bash
./bin/import_from_csv localhost spec/fixtures/csv/gse_metadata.csv ../hyku-objects
```

### from purl:

```bash
./bin/import_from_purl ../hyku-objects bc390xk2647 bc402fk6835 bc483gc9313
```
