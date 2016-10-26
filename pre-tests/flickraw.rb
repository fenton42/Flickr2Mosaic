require 'flickraw'
require 'yaml'
require 'open-uri'
require 'logger'

require 'pry-byebug'

class TagHelper
  def initialize(tags,taglist)
    @tags=tags
    @taglist=taglist
    @already={}
  end

  def fetch_tag
    ret = nil
    unless @tags.empty?
      ret = @tags.shift
    else
      ret = @taglist.sample
    end
    if @already.has_key? ret
      ret = fetch_tag
    end
    @already[ret]=true
    ret
  end
end

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG

api_key=File.read('../secrets/api_key.txt').chomp
secret_key = File.read('../secrets/secret.txt').chomp
logger.debug api_key
logger.debug secret_key
FlickRaw.api_key=api_key
FlickRaw.shared_secret=secret_key


#get nice tags 
unless File.exist?('taglist.txt') 
  File.open('taglist.txt','w') do |file|
    flickr.tags.getHotList["tag"].map{|a| a["_content"]}.each do |tag|
      file.puts tag
    end
    #tags=flickr.tags.getHotList[:h][:tag].map{|a| a._content}
  end
end


taglist = File.readlines('taglist.txt')
tags = %w(sport red black white school) #I know they work. Just testing...
num=1
tag_helper = TagHelper.new(tags,taglist)

already={}
while (num <= 10 ) do
  tag = tag_helper.fetch_tag
  puts tag

  #Note: This matches 
  #https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=MYAPI_KEY&tags=potus&sort=interestingness-desc&per_page=3&format=json&auth_token=bla-0&api_sig=blubb
  photos= flickr.photos.search({tags: tag, sort: 'interestingness-desc', per_page: 10}).to_a
  id = photos.shift.id
  while already.has_key? id #I know.. bad things will happen if nothing left...
    id = photos.shift.id
  end
  already[id]=true

  info = flickr.photos.getInfo(:photo_id => id)
  url= FlickRaw.url_b(info)
  logger.debug url
  open(url) do |f|
    File.open("#{num}.jpg","wb") do |file|
      file.puts f.read
    end
  end 
  num +=1
end

canvas_x=1024
canvas_y=768

#TODO put all pictures on a canvas using a defined layout (crop pictures)
#what about nice cropping? Orientation...

# sizes = flickr.photos.getSizes :photo_id => id
#
# original = sizes.find {|s| s.label == 'Original' }
# logger.debug original.width
#
#
# list   = flickr.photos.getRecent
# id     = list[0].id
# secret = list[0].secret
#info = flickr.photos.getInfo :photo_id => id, :secret => secret
