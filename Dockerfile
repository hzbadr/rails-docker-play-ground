FROM ruby:alpine

RUN apk add --update build-base postgresql-dev tzdata

RUN gem install rails -v '5.2.1'

WORKDIR /app
ADD Gemfile Gemfile.lock /app/
RUN bundle install --jobs 20 --retry 5

COPY . .

RUN rm -rf tmp/*

CMD ["bundle", "exec", "rails", "s"]
