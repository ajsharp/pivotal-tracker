$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

project_root = File.expand_path(File.dirname(__FILE__))
require File.join(project_root, '..', 'vendor', 'gems', 'environment')
Bundler.require_env(:test)
 
require 'pivotal-tracker'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  # config.include(Rack::Test::Methods)
end

def test_happy_mapper(expected_hash, object)
  expected_hash.keys.each do |attribute|
    object.send(attribute).should == expected_hash[attribute]
  end

  object_elements = object.class.elements.collect {|element| element.name.to_sym }
  if expected_hash.keys.size != object_elements.size
    if expected_hash.keys.size > object_elements.size
      raise "More expected elements than #{object.class.to_s} elements: #{(expected_hash.keys - object_elements).inspect}"
    else
      raise "More #{object.class.to_s} elements than expected elements: #{(object_elements - expected_hash.keys).inspect}"
    end
  end
end
