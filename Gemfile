source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'bootstrap', '~> 4.0.0.beta3'
gem 'sass-rails', '~> 5.0'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt'

group :development, :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'pry'
  gem 'rspec-rails', '~> 3.6'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
