#TODO not so sure whether I should put these errors in a special module/file
class TagListFormatError < RuntimeError
end

module Flickr2Mosaic

  class Taglist
    attr_accessor :taglist_file
    attr_accessor :taglist
    attr_accessor :taglist_limit

    def initialize(params={})
      #TODO shorten this long method
      self.taglist_file = params[:filename]
      self.taglist_limit = params[:limit] || 1000 #1000 tags should be enough
      if self.taglist_file 
        if File.exist? self.taglist_file
          self.taglist = Array.new
          pre_taglist = File.readlines( taglist_file, self.taglist_limit )
          num=1
          pre_taglist.each do |line|
            if line =~ /^(\w+)[\r\n]*$/
              self.taglist << $1
            else
              raise TagListFormatError, "Format Error in line #{num}. Only 1 word per line allowed. Filename: #{self.taglist_file}"
            end
            num += 1
          end
        else
          raise "File not found #{self.taglist_file}"
        end
      else
        self.taglist = self.hotlist(self.taglist_limit)
      end
    end

    def next
      self.taglist.shift
    end

    #This being more or less a goodie. I could also just raise an exception
    #if there is no file with tags...
    def hotlist(count=20)
      flickr.tags.getHotList(count: count)["tag"].map{|a| a["_content"]}
    end

  end
end
