# From the Ruby base image
FROM ruby:3.0.4 as base

# Create a directory
WORKDIR /rails-getting-started

# Install dependencies in the container
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    sudo \
    postgresql \
    postgresql-contrib \
    curl \
    libvips \
    libpq5 \
    openssl \
    tzdata

# RAILS_ENV environment is set to production.
ENV RAILS_ENV production

# RAILS_SERVE_STATIC_FILES is set to allow the app to serve static files which is otherwise disabled by default.
ENV RAILS_SERVE_STATIC_FILES true

# RAILS_LOG_TO_STDOUT is set to log to standard out instead of a file.
ENV RAILS_LOG_TO_STDOUT true

# Copy the Gemfile and the Gemfile.lock in the container app folder.
COPY Gemfile .
COPY Gemfile.lock .

# Install ruby gems
RUN bundle install

# Copy all the project
COPY . .

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose the application port
EXPOSE 3000

# Start the Rails Application
CMD ["sh", "production-deployment.sh"]
