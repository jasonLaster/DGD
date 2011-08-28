source 'http://rubygems.org'


gem 'rails', '3.1.0.rc5'
gem "heroku"
gem 'haml'
gem 'haml-rails', :group => :development
gem 'jquery-rails'
gem 'redcarpet'
gem 'omniauth'


group :development, :test do
  gem 'sqlite3'
end

group :development do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'sqlite3'
end

group :test do
  gem 'turn', :require => false
end

group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-script'
  gem 'uglifier'
end



group :production do
  gem 'thin'
  gem 'execjs'
end
