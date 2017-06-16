FROM ruby:2.3.1
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs libreoffice imagemagick unzip libmediainfo0 libzen0 && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /opt/fits && \
    curl -fSL -o /opt/fits-1.1.1.zip http://projects.iq.harvard.edu/files/fits/files/fits-1.1.1.zip && \
    cd /opt && unzip fits-1.1.1.zip && chmod +X fits-1.1.1/fits.sh

RUN mkdir /data
WORKDIR /data
# Make sure to verify your build is small with the .dockerignore file
#COPY Gemfile Gemfile.lock bin lib config config.ru db LICENSE Rakefile README.md spec vendor ./
COPY . ./
RUN bundle install
RUN bundle exec rake assets:precompile
EXPOSE 3000
