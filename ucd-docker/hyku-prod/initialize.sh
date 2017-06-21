#! /bin/bash
dc='docker-compose'
dcpg='docker-compose exec --user postgres db'
${dcpg} pg_restore --dbname=postgres /io/hyku-startup.Fc
${dc} exec fcrepo curl --data '/io/startup' localhost:8080/fcrepo/rest/fcr:restore
${dc} exec web bundle exec rails runner "ActiveFedora::Base.reindex_everything"
