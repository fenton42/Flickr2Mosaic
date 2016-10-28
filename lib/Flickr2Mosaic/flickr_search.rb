require 'flickraw'
require 'open-uri'

module Flickr2Mosaic
  class FlickrSearch

    def initialize(params={})
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG

      api_key=params[:api_key] || ENV[:FLICKR_API_KEY.to_s] || fetch_key_from_file('~/.flickr2mosaic/api_key.txt') || fetch_key_from_file('./secrets/api_key.txt')
      secret_key = params[:secret_key] || ENV[:FLICKR_SECRET_KEY.to_s] || fetch_key_from_file('~/.flickr2mosaic/secret_key.txt') || fetch_key_from_file('./secrets/secret_key.txt')

      raise "API-Key for Flickr is missing. Use 'export FLICKR_API_KEY=yourkey' in your shell to proceed." if api_key.to_s.blank?
      raise "SECRET-Key for Flickr is missing. Use 'export FLICKR_SECRET_KEY=yourkey' in your shell to proceed." if secret_key.to_s.blank?
      FlickRaw.api_key=api_key
      FlickRaw.shared_secret=secret_key
    end

    def fetch_key_from_file(filename)
      begin
        File.read(File.expand_path(filename)).chomp 
      rescue Exception => e
      #  puts e.message
      end
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
          begin
            info = flickr.photos.getInfo(:photo_id => id)
            url = FlickRaw.url_b(info)
          rescue FlickRaw::FailedResponse => e
            STDERR.puts e.message
          end
          if already_found.include? url
            #loop again
            url=nil
          end
        end
      end
      STDERR.puts "photo for tag #{tag}"
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
