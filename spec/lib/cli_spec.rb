require 'spec_helper'

module Flickr2Mosaic
  describe CLI do
    it "should be able to call start" do
      VCR.use_cassette(:cli_start) do
        expect{Flickr2Mosaic::CLI.start}.not_to raise_error
      end
    end
  end
end

