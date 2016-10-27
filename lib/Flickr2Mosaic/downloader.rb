module Flickr2Mosaic
  class  Downloader
    attr_accessor :output_dir
    def initialize(params={})
      #I can't use a tempfile/tempdir block, as I need the files for later
      self.output_dir = params[:output_dir] || '/tmp/'
    end

    #Just downloads the file from the given url
    #it will raise an exception if something goes wrong.
    #I don't see the point in catching it to just make a nicer text...
    #for example: if the filename can't be written
    #Errno::ENOENT: No such file or directory @ rb_sysopen - a/tmp/29969001523_f45c759c80_b.jpg
    #
    #returns the full path of the image
    def download(url,filename=nil)
      path = File.join(self.output_dir,filename_from_url(url))
      open(url) do |f|
        File.open(path,"wb") do |file|
          file.puts f.read
        end
      end 
      path
    end

    private 
    def filename_from_url(url) 
      parts = url.split(/\//)
      parts.last
    end
  end
end
