module Flickr2Mosaic
  class  Downloader
    attr_accessor :output_dir
    def initialize(params={})
      #I can't use a tempfile/tempdir block, as I need the files for later
      self.output_dir = params[:output_dir] || '/tmp/'
    end

    def download(url,filename=nil)
      unless Dir.exists? self.output_dir
        raise "The desired output directory #{self.output} does not exist"
      end
      open(url) do |f|
        File.open(File.join(self.output_dir,filename_from_url(url)),"wb") do |file|
          file.puts f.read
        end
      end 
    end

    private 
    def filename_from_url(url) 
      parts = url.split(/\//)
      parts.last
    end
  end
end
