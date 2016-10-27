require "flickr2mosaic/version"

require 'flickr2mosaic/c_l_i'
require 'flickr2mosaic/parser'
require 'flickr2mosaic/processing'
require 'flickr2mosaic/downloader'
require 'flickr2mosaic/mosaic_generator'
require 'flickr2mosaic/flickr_search'
require 'flickr2mosaic/taglist'

require 'logger'
require 'yaml'

module Flickr2Mosaic
  # Your code goes here...
end

#just copied from Rails
class String
  BLANK_RE = /\A[[:space:]]*\z/

  # A string is blank if it's empty or contains whitespaces only:
  #
  #   ''.blank?       # => true
  #   '   '.blank?    # => true
  #   "\t\n\r".blank? # => true
  #   ' blah '.blank? # => false
  #
  # Unicode whitespace is supported:
  #
  #   "\u00a0".blank? # => true
  #
  # @return [true, false]
  def blank?
    # The regexp that matches blank strings is expensive. For the case of empty
    # strings we can speed up this method (~3.5x) with an empty? call. The
    # penalty for the rest of strings is marginal.
    empty? || BLANK_RE === self
  end
end

