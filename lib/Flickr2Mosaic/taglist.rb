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
          self.taglist = read_lines_until_limit
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

    private

    def read_lines_until_limit
      local_taglist = Array.new
      numlines=0
      File.open( taglist_file ).each do |line|
        break if numlines >= self.taglist_limit
        next if line.blank? 
        if line =~ /^(\w+)[\r\n]*$/
          local_taglist << $1
        else
          raise TagListFormatError, "Format Error in line #{numlines}. Only 1 word per line allowed. Filename: #{self.taglist_file}. Line: #{line}"
        end
        numlines += 1
      end
      local_taglist
    end
  end
end
