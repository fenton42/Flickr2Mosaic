module Flickr2Mosaic
  class Processing

    attr_accessor :tmpdir
    def initialize(params={})
      self.tmpdir = params[:tmpdir] || '/tmp' 
    end

    def perform
      download()
      create_mosaic()
    end

    def fetch_urls
      1.upto 10
    end

    def download
      1.upto 10 do |num|
        File.open( [self.tmpdir, num.to_s+".jpg"].join('/'),"w"){}
      end
    end

    def create_mosaic
    end
  end
end
