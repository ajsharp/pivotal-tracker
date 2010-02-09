$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

begin
  # Require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end
Bundler.require(:default, :test)

require 'pivotal-tracker'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  # config.include(Rack::Test::Methods)
end
