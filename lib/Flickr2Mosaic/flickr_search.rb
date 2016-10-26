require 'flickraw'
require 'open-uri'

module Flickr2Mosaic
  class FlickrSearch

    def initialize
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG

      api_key=File.read('./secrets/api_key.txt').chomp
      secret_key = File.read('./secrets/secret.txt').chomp
      @logger.debug api_key
      @logger.debug secret_key
      FlickRaw.api_key=api_key
      FlickRaw.shared_secret=secret_key
    end

    def get_url_by_search_tag(tag)
      photos=flickr.photos.search({tags: tag, sort: 'interestingness-desc', per_page: 10}).to_a
      if photos
        id = photos.shift.id
        info = flickr.photos.getInfo(:photo_id => id)
        FlickRaw.url_b(info)
      else
        nil
      end
    end
  end
end
