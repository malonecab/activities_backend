FROM ruby:2.5.1-alpine3.7
LABEL maintainer="malonecab@gmail.com"

RUN apk add --update build-base \
                     postgresql-dev \
                     tzdata \
&& rm -rf /var/cache/apk/*


ENV APP_PATH /var/www/backend/

WORKDIR $APP_PATH
COPY Gemfile* $APP_PATH

RUN bundle install

COPY . $APP_PATH

# Rails server is started as the first process in the container (PID 1) and correctly receives Unix signals such as the signal to terminate.
CMD ["rails", "s", "-b", "0.0.0.0"]
