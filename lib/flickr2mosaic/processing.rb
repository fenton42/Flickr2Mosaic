module Flickr2Mosaic
  class Processing

    attr_accessor :tmpdir
    attr_accessor :user_taglist
    attr_accessor :numpics

    attr_accessor :opt_filename
    attr_accessor :opt_tags


    attr_accessor :urls
    attr_accessor :filenames

    attr_accessor :output_file


    def initialize(params={})
      self.tmpdir       = params[:tmpdir] || '/tmp'
      self.numpics      = params[:numpics] || 10
      self.opt_filename = params[:filename] || nil
      self.opt_tags     = params[:tags] || []
      self.output_file  = params[:output] || '/tmp/output.jpg'
      #puts self.to_yaml


      #TODO Refactor: I'd prefer to initialize the taglist with the user given parameters.
      #screams: Refactor me...
      self.user_taglist = params[:user_taglist] || []
    end

    #the actual processing when the program is called
    #error handling being performed inside subroutines, i.e. via exceptions
    def perform
      fetch_urls
      download_all
      create_mosaic
      cleanup
    end

    def fetch_urls
      taglist = Taglist.new(limit: self.numpics*5, 
                            filename: self.opt_filename,
                            own_tags: self.opt_tags,
                            user_tags: self.user_taglist)
      urls=[]
      10.times do
        url=nil
        while !url do
          tag = taglist.next
          raise "Your taglist is too short for 10 pictures: No more tags available" if tag.nil?
          puts "trying to find photos for tag #{tag.to_s}"
          #do not use double images. Therefore the urls-array has to be provided
          url = FlickrSearch.new.get_url_by_search_tag(tag,urls)
        end
        urls << url
      end
      @urls=urls
    end

    def download_all
      downloader = Downloader.new(tmpdir: self.tmpdir)
      @filenames=[]
      @urls.each do |url|
        @filenames << downloader.download(url)
      end
      @filenames
    end

    def cleanup
      @filenames.each do |filename|
        #Exception will be raised by File.delete
        File.delete(filename)
      end
    end

    def create_mosaic
      mosaic_generator = MosaicGenerator.new(:filenames => self.filenames,
                                             :output_file => self.output_file)
      mosaic_generator.perform
    end


  end
end
