FROM ruby:2.5.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

## Create folder
RUN mkdir /myapp

## Set working dir
WORKDIR /myapp

## Copy gemfile
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

COPY . /myapp

EXPOSE 3000