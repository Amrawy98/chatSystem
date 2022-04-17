From ruby:2.7.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /chatSystem
WORKDIR /chatSystem
ADD Gemfile /chatSystem/Gemfile
ADD Gemfile.lock /chatSystem/Gemfile.lock

RUN bundle install
RUN rails db:migrate
ADD . /chatSystem