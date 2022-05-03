source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'blueprinter'
gem 'pg'
gem 'pry', '~> 0.13.1'
gem 'puma', '~> 5.0'
gem 'oj'
gem 'rack-cors'
gem 'rails', '~> 6.1.5'
gem 'rswag-api'
gem 'rswag-ui'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails', '6.0.0.rc1'
  gem 'rswag-specs'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
