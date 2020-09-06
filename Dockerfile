FROM ruby:2.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /Scraping_app
WORKDIR /Scraping_app
COPY Gemfile //Gemfile
COPY Gemfile.lock /Scraping_app/Gemfile.lock
RUN bundle install
COPY . /Scraping_app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3004

CMD ["rails", "server", "-b", "0.0.0.0"]
