source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'russian', '~> 0.6.0'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'auto_migrations', :git => 'git://github.com/antage/auto_migrations.git'
gem 'devise' # rails_admin dependency
gem "ckeditor", "3.7.0.rc3"
gem 'paperclip', '~> 3.0'
gem 'paperclip-meta'
gem 'yaml_db', :git => 'git://github.com/lostapathy/yaml_db.git'
gem 'unicorn'
gem 'will_paginate', '~> 3.0'
gem 'squeel' # dependency of exception_notification
gem 'exception_notification', :git => 'git://github.com/alanjds/exception_notification.git'
gem "exception_logger", :git => 'git://github.com/ryancheung/exception_logger.git'
gem 'pg'

group :development do
end
group :test do
  gem 'sqlite3'
end
group :production do
  gem 'mysql2'
end

gem 'capistrano'
gem 'rvm-capistrano'
#gem 'capistrano-deepmodules'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'