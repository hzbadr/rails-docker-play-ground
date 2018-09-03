FROM ruby:alpine

RUN apk add --update build-base postgresql-dev tzdata

RUN gem install rails -v '5.2.1'

WORKDIR /app
ADD Gemfile Gemfile.lock /app/

ENV BUNDLE_PATH=/bundle \
  BUNDLE_BIN=/bundle/bin \
  GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

COPY . .

COPY ./docker-entrypoint.sh ./
RUN chmod +x ./docker-entrypoint.sh
ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]

RUN rm -rf tmp/*

CMD ["bundle", "exec", "rails", "s"]
