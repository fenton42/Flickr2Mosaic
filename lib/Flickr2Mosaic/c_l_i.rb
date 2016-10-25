module Flickr2Mosaic
  class CLI
    def self.start
      Processing.new.perform
    end
  end
end
