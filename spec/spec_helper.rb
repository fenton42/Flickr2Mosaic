$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "flickr2mosaic"

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :new_episodes }
  c.allow_http_connections_when_no_cassette = false
end

RSpec.configure do |c|
end
