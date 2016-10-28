module Flickr2Mosaic
  class MosaicGenerator
    attr_accessor :layout
    attr_accessor :width_x
    attr_accessor :width_y
    attr_accessor :filenames

    #needs params[:filenames] to be an array[10] of filenames
    def initialize(params={})
      #
      #3 rows with 4 elements, thus 12 fields
      #we need only 10 fields, therefore 2 of them have to be doubled.
      #The doubled pictures will be cropped differently (i.e. double hight or double width)
      self.layout = params[:layout] || [ 1, 1, 2, 3,
                                         4, 5, 6, 7,
                                         8, 9,10, 7 ]

      self.width_x = params[:width_x] || 1280
      self.width_y = params[:width_y] ||  960

      self.filenames = params[:filenames] 
      if self.filenames.count != 10 #TODO change "10" to a parameter
        raise "I need exactly 10 filenames, urls, tags to create a nice looking collage grid. I have received #{self.filename.count}"
      end

      #TODO what about fractions? 
      #will only be a problem, if the output size can be chosen by the cli-user
      @column_width  = self.width_x / 4
      @column_height = self.width_x / 3
    end

    #if x_count = 1 and y_count=1 it matches exactly 1 field
    #if x_count = 2 and y_count=1 it matches 2 x-neighboured fields
    #a.s.o
    def resize_picture(filename,x_count=1, y_count=1)
      x = self.width_x * x_count
      y = self.width_y * y_count

      #modifies the image in place
      image = MiniMagick::Image.new(filename)
      #image.path #=> "input.jpg"
      #
      #resizing so that it fits more or less the field size. Don't stretch it
      image.resize "100x100^"  #the "^" means _minimum_ 100x100, so it may be 200x100 but not 100x50
      image.crop "100x100+0+0" #offset may need to be calculated. 1 side should already be OK
                               #the other has to be moved by (current-desired)/2 -1 (-1 to be save)
      see above comments!
    end
  end
end
