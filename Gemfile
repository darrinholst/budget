source 'https://rubygems.org'

gem 'rails', '3.2.2'

gem 'bourbon'
gem 'chronic'
gem 'draper'
gem 'jquery-rails'
gem 'money'
gem 'twitter-bootstrap-rails'

group :development, :test do
  gem 'sqlite3'       , :require => false
  gem 'growl'         , :require => false
  gem 'guard-bundler' , :require => false
  gem 'guard-rails'   , :require => false , :git => "https://github.com/johnbintz/guard-rails"
  gem 'rb-fsevent'    , :require => false
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'handlebars_assets'
end

group :production do
  gem 'heroku'
  gem 'pg'
end

