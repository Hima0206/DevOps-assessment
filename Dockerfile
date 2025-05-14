FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /app
COPY . /app 

# Install gems
RUN gem install blunder && bundle install


#Add entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]


# Expose the port the app runs on
EXPOSE 3000

# Use the default command to start the server
CMD ["rails", "server", "-b", "0.0.0.0"]




