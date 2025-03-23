# syntax=docker/dockerfile:1
# This Dockerfile is designed for production, not development.

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2.3
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Set up working directory for the Rails app
WORKDIR /rails

# Install base packages for Rails and dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    sqlite3 \
    build-essential \
    git \
    libyaml-dev \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# ------------------------
# Build stage to install gems and precompile assets
FROM base AS build

# Copy the Gemfile and Gemfile.lock to install dependencies
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy the rest of the application code into the container
COPY . .

# Precompile assets for production (without requiring RAILS_MASTER_KEY)
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# ------------------------
# Final stage for production app image
FROM base

# Copy over the installed gems from the build stage
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Create a non-root user to run the app securely
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

# Switch to the non-root user
USER 1000:1000

# Set the entrypoint to prepare the database
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose port 80 (for the Rails app)
EXPOSE 80

# Default command to start the Rails server
CMD ["./bin/thrust", "./bin/rails", "server"]
