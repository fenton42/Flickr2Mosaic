require 'mini_magick'

module Flickr2Mosaic
  class Magick

    attr_accessor :filename

    def initialize(params={})
      self.filename = params[:filename]
    end

    def resize( x, y, offset_x=0, offset_y=0)
      #modifies the image in place
      image = MiniMagick::Image.new(filename)

      #image.path #=> "input.jpg"
      #
      #resizing so that it fits more or less the field size. Don't stretch it
      image.resize to_mm_resize(x,y)
      image.crop to_mm_crop(x,y,0,0)
      #the other has to be moved by (current-desired)/2 -1 (-1 to be save)
    end

    private

    def to_mm_resize(width_x, width_y)
      #the "^" means _minimum_ 100x100, so it may be 200x100 but not 100x50
      "#{width_x.to_i}x#{width_y.to_i}^"
    end

    def to_mm_crop(width_x, width_y, x_offset=0, y_offset=0)
      #offset may need to be calculated. 1 side should already be OK
      "#{width_x.to_i}x#{width_y.to_i}+#{x_offset.to_i}+#{y_offset.to_i}"
    end
  end
end
