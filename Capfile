require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rails'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'
require 'capistrano/rvm'
set :rvm_type, :user
set :rvm_ruby_version, '2.2.0p0'
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
