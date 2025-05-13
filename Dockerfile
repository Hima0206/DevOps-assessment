FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Install gems
RUN gem install blunder && bundle install
COPY . /myapp


# Precompile assets
RUN bundle exec rake assets:precompile
RUN bundle exec rake db:migrate

# Expose the port the app runs on
EXPOSE 3000

# Use the default command to start the server
CMD ["rails", "server", "-b", "0.0.0.0"]


