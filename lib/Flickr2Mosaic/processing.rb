module Flickr2Mosaic
  class Processing

    attr_accessor :tmpdir
    attr_accessor :user_taglist
    attr_accessor :numpics

    def initialize(params={})
      self.tmpdir       = params[:tmpdir] || '/tmp'
      self.numpics      = params[:numpics] || 10

      #TODO Refactor: I'd prefer to initialize the taglist with the user given parameters.
      #screams: Refactor me...
      self.user_taglist = params[:user_taglist] || []
    end

    #the actual processing when the program is called
    #error handling being performed inside subroutines, i.e. via exceptions
    def perform
      urls = fetch_urls
      urls.each do |url| 
        download(url)
      end
      create_mosaic
    end

    def fetch_urls
      taglist = Taglist.new(limit: self.numpics*5, user_tags: self.user_taglist)
      # 1.upto self.numpics do
      #
      # end
      urls = 1.upto self.numpics { "bla" }
    end

    def download(url)
      1.upto 10 do |num|
        File.open( [self.tmpdir, num.to_s+".jpg"].join('/'),"w"){}
      end
    end

    def create_mosaic
    end


  end
end
