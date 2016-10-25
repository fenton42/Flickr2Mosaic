require 'flickraw'
require 'yaml'
require 'open-uri'
require 'logger'

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG

api_key=File.read('../secrets/api_key.txt').chomp
secret_key = File.read('../secrets/secret.txt').chomp
logger.debug api_key
logger.debug secret_key
FlickRaw.api_key=api_key
FlickRaw.shared_secret=secret_key

# list   = flickr.photos.getRecent
#
# id     = list[0].id
# secret = list[0].secret
#info = flickr.photos.getInfo :photo_id => id, :secret => secret
tags = %w(sport red black white school) #I know they work. Just testing...
num=1
already={}
tags.each do |tag|
  photos= flickr.photos.search({tags: tag, sort: 'interestingness-desc', per_page: 10}).to_a
  #Note: This matches 
  #https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=MYAPI_KEY&tags=potus&sort=interestingness-desc&per_page=3&format=json&auth_token=bla-0&api_sig=blubb
  id = photos.shift.id
  while already.has_key? id #I know.. bad things will happen if nothing left...
    id = photos.shift.id
  end
  already[id]=true

  info = flickr.photos.getInfo(:photo_id => id)
  url= FlickRaw.url_b(info)
  logger.debug url
  open(url) {|f|
    File.open("#{num}.jpg","wb") do |file|
      file.puts f.read
    end
  }
  num +=1
end

#TODO  fetch missing entries from word list (easy)
#TODO put all pictures on a canvas using a defined layout (crop pictures)
#what about nice cropping? Orientation...

# sizes = flickr.photos.getSizes :photo_id => id
#
# original = sizes.find {|s| s.label == 'Original' }
# logger.debug original.width
