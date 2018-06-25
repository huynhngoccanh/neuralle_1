source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '~>4.2.0'
gem 'rake'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
# gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'unicorn'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'font-awesome-rails'
gem 'pg'
gem 'momentjs-rails'
gem 'rack-cors'
gem 'figaro'
gem 'haml'
gem 'haml-rails', '~> 0.9'
# We need carrierwave to make podcast files uploading work
gem 'carrierwave'
gem 'carrierwave_direct'
gem 'carrierwave_backgrounder'
# We need fog-aws to make carrierwave work
gem 'fog-aws'
# Background processor to make carrierwave direct uploads work
gem 'sidekiq'
gem 'auto_strip_attributes', '~> 2.1'
gem 'social-share-button'
# quite log
gem "lograge"
gem 'owlcarousel-rails'
gem 'bootstrap-slider-rails'
gem 'simple_form'
gem "recaptcha", require: "recaptcha/rails"
gem 's3_direct_upload'
gem 'country_select'
gem 'stripe'
gem 'oauth2'
gem 'remotipart', '~> 1.2'
# bitpay
gem 'bitpay-sdk'

group :production do
  gem 'dragonfly-s3_data_store'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end

group :development do
  gem 'spring'
  gem 'quiet_assets'
  gem 'derailed'
  gem 'foreman'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'pry'
end

group :test do
  gem 'database_cleaner'
end

gem 'sdoc', '~> 0.4.0',          group: :doc

# Refinery
gem 'refinerycms', '~> 3.0'

# Blog
gem 'refinerycms-blog', git: 'https://github.com/refinery/refinerycms-blog', branch: 'master'
gem 'rails-html-sanitizer'

# Add support for searching inside Refinery's admin interface.
gem 'refinerycms-acts-as-indexed', ['~> 2.0', '>= 2.0.0']

# Add support for Refinery's custom fork of the visual editor WYMeditor.
gem 'refinerycms-wymeditor', ['~> 1.0', '>= 1.1.0']
gem 'refinerycms-videojs', git: 'https://github.com/anitagraham/refinerycms-videojs.git'

# Authentication
gem 'refinerycms-authentication-devise', '~> 1.0.4'

gem 'refinerycms-footers', path: 'vendor/extensions'
gem 'refinerycms-service_options', path: 'vendor/extensions'

gem 'refinerycms-podcast', '~> 1.0', '>= 1.0.1'
