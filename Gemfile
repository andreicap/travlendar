source 'https://rubygems.org'

ruby '2.4.1'
gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # gem guard
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#views
gem 'bootstrap', git: 'https://github.com/twbs/bootstrap-rubygem'
gem 'popper_js'
gem "font-awesome-rails"

#auth
gem 'devise'
gem "omniauth-google-oauth2"
gem 'google-api-client', '0.8.2', require: 'google/api_client'  

#utils
gem 'rest-client'
gem 'high_voltage'
gem 'jquery-rails'

#db
gem 'pg'

group :development do
  gem 'better_errors'
  gem 'rails_layout'
end

group :production do
  gem 'rails_12factor'
end

