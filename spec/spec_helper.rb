$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "Flickr2Mosaic"

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :new_episodes }
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |c|
end
