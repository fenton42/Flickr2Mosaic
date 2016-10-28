module Flickr2Mosaic
  class CLI
    def self.start(params=[])
      Parser.parse(params)
      Processing.new.perform
    end
  end
end
