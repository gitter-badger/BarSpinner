source 'https://rubygems.org'

gem 'rails', '3.2.18'

gem 'mysql2'
gem 'devise'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem "twitter-bootstrap-rails", '2.2.8'
gem "simple_form"
gem 'haml'
gem 'haml-rails'
gem 'inherited_resources'
gem 'jquery-minicolors-rails'
gem "validate_url"
gem 'coffee-rails', '~> 3.2.1'



group :assets do
  gem "less-rails", '2.4.2'
  gem 'less', '2.4.0'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'thin', '1.5.1'
  gem 'quiet_assets', '1.0.2'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'meta_request', '0.2.1'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'pry-debugger'
  gem 'rspec-rails'
end

group :test do
  gem 'factory_girl_rails'
  gem 'mocha', '0.13.2', :require => false
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end


#deploy 
gem 'rvm-capistrano'
gem 'capistrano'
gem "net-ssh", "~> 2.7.0"