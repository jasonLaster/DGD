source 'http://rubygems.org'


gem 'rails', '~> 3.1.0'

gem 'haml'
gem 'jquery-rails'
gem 'redcarpet'
gem 'omniauth', '0.2.6'
gem 'nokogiri'
gem 'bootstrap-wysihtml5-rails'
gem 'formtastic'
gem 'dalli'

gem 'exceptional'
gem 'newrelic_rpm'


group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-script'
  gem 'uglifier'
  gem 'less'
end


gem "rspec-rails", :group => [:test, :development]

group :test do
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'turn', :require => false

  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem "plymouth"
end

group :development do
  gem 'heroku'
  gem 'sqlite3'
  gem 'haml-rails'
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :production do
  # gem 'thin'
  # gem 'execjs'
  gem 'pg'
end
