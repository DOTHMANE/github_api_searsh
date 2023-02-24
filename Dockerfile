FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /github_search_app
WORKDIR /github_search_app
ADD Gemfile /github_search_app/Gemfile
ADD Gemfile.lock /github_search_app/Gemfile.lock
RUN bundle install
ADD . /github_search_app
