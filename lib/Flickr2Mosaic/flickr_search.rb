require 'flickraw'
require 'open-uri'

module Flickr2Mosaic
  class FlickrSearch

    def initialize
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG

      api_key=File.read('./secrets/api_key.txt').chomp
      secret_key = File.read('./secrets/secret.txt').chomp
      #@logger.debug api_key
      #@logger.debug secret_key
      FlickRaw.api_key=api_key
      FlickRaw.shared_secret=secret_key
    end

    def get_url_by_search_tag(tag,already_found=[])
      url=nil
      photos=flickr.photos.search({tags: tag, sort: 'interestingness-desc', 
                                   per_page: 15,
                                   content_type: 1 #just photos 
      }).to_a
      #@logger.debug photos.to_yaml
      unless photos.nil? or photos.empty?
        while url.nil?
          id = photos.shift.id
          #should never happen: Fetch 15 pictures, only 9 can be in list
          raise "No more pictures left that haven't already been used" unless id
          info = flickr.photos.getInfo(:photo_id => id)
          url = FlickRaw.url_b(info)
          if already_found.include? url
            #loop again
            url=nil
          end
        end
      end
      url
    end

    def get_hotlist(count)
      flickr.tags.getHotList(count: count)["tag"].map{|a| a["_content"]}
    end

    def get_urls_by_tags(taglist) 
      urllist = Array.new
      taglist.each do |tag|
        url = get_url_by_search_tag(tag)
        if url
          urllist << url 
        end
      end
      urllist
    end
  end
end
