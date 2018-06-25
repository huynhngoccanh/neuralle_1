FROM ruby:2.2.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs apt-transport-https apt-utils
RUN apt-get install -y graphviz

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

ENV DIR /var/www
RUN mkdir $DIR
WORKDIR $DIR
ADD . $DIR
RUN cp docker/config/database.yml $DIR/config

ENV BUNDLE_GEMFILE=$DIR/Gemfile \
BUNDLE_JOBS=2 \
BUNDLE_PATH=/bundle
