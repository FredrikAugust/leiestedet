source 'https://rubygems.org'

ruby '>= 2.2.6'

gem 'rails', '> 5.0.0'
# postgres
gem 'pg', '~> 0.18'
# server
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'materialize-sass'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
# authentication
gem 'devise'
# image uploading
gem 'mini_magick'
gem 'will_paginate'
gem "fog"
gem "fog-google"
gem "google-api-client", ">= 0.6.2", "< 0.9"
gem "mime-types"
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'letsencrypt_plugin'

group :development, :test do
  gem 'byebug', platform: :mri
  # spec
  gem 'rspec-rails'
  # generate fixtures
  gem 'factory_girl_rails'
  # clean db after each test
  gem 'database_cleaner'
  # extension for rspec so I can test controllers
  gem 'rails-controller-testing'
  # generate "random" data to use in tests/seeds
  gem 'faker'
  # load env vars from .env
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # watch for changes and run spec
  gem 'guard-rspec', require: false
  gem 'brakeman'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
