# UC Davis Hyku DAMS

This is a very small modification to the hyku setup. Currently, most of the
changes are just to get it working in a development docker setup.

We use the dev.yml file for development. This file starts up solr and postgres
in separate containers. The hope is to smooth transition to the production
server.

## Development Setup

### 1st Time installation

The `dev.yml` file is setup to start the hydra_development instance on startup.
The setup also keeps the system persistent from startup to startup, with
volumes for solr, postgres, and fcrepo.  The system uses a different fcrepo then
the `samvera-labs` setup.

On the first time instance, you need to migrate the database.

``` bash
dc exec web bundle exec rails db:migrate
```

After that, we need to go in and create some adminstrative workflows

### Restart

If you turn off the system with `dc down`, you should be able to turn it back on
with `dc up -d`.  The data should be persistent between those.

### Reload From Scratch

We are looking into methods that allow you to reload the development server
if you need to restart the docker volumns as well.  This requires that you have
saved the postgres database as well as the

### Saving
The dev.yml docker file includes paths that allow users to save snapshots of

``` bash
alias dcpg='dc exec --user postgres db'
d=`date --iso`
# You can backup the postgres database
dcpg pg_dump -Fc --file=/io/hyku-$d.Fc postgres
# We can also backup the fcrepo data.
mkdir io/$d; chmod 777 io/$d;
dc exec fcrepo curl --data "/io/$d" localhost:8080/fcrepo/rest/fcr:backup
```

### Restoration

``` bash
d='2017-07-06'
dcpg pg_restore --dbname=postgres /io/hyku-$d.Fc
dc exec fcrepo curl --data "/io/$d" localhost:8080/fcrepo/rest/fcr:restore
dc exec web bundle exec rails runner "ActiveFedora::Base.reindex_everything"
```


### Running as an Apache Service

In development mode, we run this application behind an apache service. This is
to allow for us to; have multiple tests running on the same server, and to
expose some of the additional components, (eg. the solr service and the fcrepo
service).

The apache2.conf file shows the setup we use to go along with the
development docker file.  Note the care that needs to be taken with proxy
serving the RIIIF filepaths in this arrangement.

# More Information

Please see the [Samvera Labs](https://github.com/samvera-labs/hyku) repository
for additional information.
