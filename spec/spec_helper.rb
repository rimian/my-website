require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../base.rb', __FILE__

RSpec.configure do |c|
  c.include Rack::Test::Methods
  def app() Sinatra::Application end
end
