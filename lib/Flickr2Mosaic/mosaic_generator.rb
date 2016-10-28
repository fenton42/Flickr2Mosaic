module Flickr2Mosaic
  class MosaicGenerator

    attr_accessor :layout
    attr_accessor :width_x
    attr_accessor :width_y
    attr_accessor :filenames

    attr_accessor :column_width
    attr_accessor :column_height

    #needs params[:filenames] to be an array[10] of filenames
    def initialize(params={})
      #I need a mapping for the images
      #
      #array
      #graphic fields  0 1 2 3 
      #                4 5 6 7
      #                8 9 10 11
      #
      #[ 1, 1, 2, 3,
      #  4, 5, 6, 7,
      #  8, 9,10, 7 ]
      # means
      #
      # pic 1 -> 0 and 1   -> x=2, y=1
      # pic 2 -> 2
      # pic 3 -> 3
      # pic 4 -> 4
      # pic 5 -> 5
      # pic 6 -> 6
      # pic 7 -> 7 and 11  -> x=1, y=2
      # pic 8 -> 8
      # pic 9 -> 9
      # pic 10->10


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
      unless self.filenames.is_a? Array and self.filenames.count == 10 #TODO change "10" to a parameter
        raise "I need exactly 10 filenames, urls, tags to create a nice looking collage grid. I haven't received them"
      end

      #TODO what about fractions? 
      #will only be a problem, if the output size can be chosen by the cli-user
      @column_width  = self.width_x / 4
      @column_height = self.width_y / 3
    end

    def perform
      resize_pictures
      create_image
    end

    def create_image
      #TODO move to magick...
      output = '/tmp/output.jpg'

      #this is documented but doesn't work... Sadly...
      #see https://github.com/minimagick/minimagick/issues/59
      # black_canvas= MiniMagick::Image.create 'jpg', false do |c|
      #   c.size( self.width_x.to_s + "x" + self.width_y.to_s)
      #   c.canvas 'black'   # creates image creation operator 'canvas:black'
      # end
      # black_canvas.write(output)
      # 
      
      MiniMagick::Tool::Convert.new do | new_image |
        new_image.size ( self.width_x.to_s + "x" + self.width_y.to_s)
        new_image.xc "black"
        new_image << output
      end


      self.filenames.each_with_index do |path,index|
        puts "path, index:  #{path},#{index}"
        #they have to be resized before
        first_image  = MiniMagick::Image.new(output)
        second_image = MiniMagick::Image.new(path)

        #see https://github.com/minimagick/minimagick
        result = first_image.composite(second_image) do |c|
          c.compose "Over"
          #I need not the position in the filename array but the first occurrence
          #in the layout array
          layout_position = self.layout.index(index+1)
          x_offset, y_offset = canvas_offset_from_position(layout_position)
          puts "x_offset, y_offset:  #{x_offset},#{y_offset}"
          c.geometry "+#{x_offset}+#{y_offset}"
        end
        result.write(output)
      end
    end

    #loop through all pictures
    def resize_pictures
      check_layout
      self.filenames.each_with_index do |filename,index|
        picnum = index + 1
        x,y = layout_sizes_for_picture(picnum)
        puts "Picture #{picnum}, layout sizes #{x}, #{y}"
        resize_picture(filename,x,y)
      end
    end


    def check_layout
      x_y_value_per_pic = {}
      1.upto 10 do |pic_num|
        #puts pic_num
        x,y = layout_sizes_for_picture(pic_num)
        x_y_value_per_pic[pic_num]=[x,y]
        #puts "Picture #{pic_num}, layout sizes #{x}, #{y}"
      end
      #puts x_y_value_per_pic.to_yaml
      x_y_value_per_pic
    end

    private

    def layout_sizes_for_picture(pic_num) 
      pic_pos=[]
      self.layout.each_with_index do |value,index|
        #puts "v #{value} i #{index}"
        next unless value == pic_num
        pic_pos << index
      end

      case pic_pos.count
      when 0
        raise "Missing layout position for picture #{pic_num}"
      when 1
        return 1,1
      when 2
        return check_picture_positions_and_return_size(pic_pos)
      else 
        raise "Only 2 occurences of a picture are allowed. Check your layout"
      end
    end

    #check whether the given layout makes sense and
    #returns (x,y) the size of the given picture
    def check_picture_positions_and_return_size(pic_pos)
      #(4x3 matrix)
      #
      #allowed: 0,1; 1,2; 2,3; 3,4 (x-position) resp. their modulo values --> x=2; y=1
      #
      x1 = pic_pos.shift
      x2  =pic_pos.shift
      #puts x1
      #puts x2

      if (x1+1 == x2) && (x1 % 4 == 0)
        return 2,1
      end

      if (x1+4 == x2) && (x1 < 8)
        return 1,2
      end
      raise "Strange layout. Pictures have to be neighbours vertically or horizontally"
      #allowed: 0,4; 4,8
      #allowed: 1,5; 5,9
      #allowed: 2,6; 6,10
      #allowed: 3,7; 7,11
      #--> x=1; y=2

    end

    def canvas_offset_from_position(pos) #position in array
      # 0 -> 0,0
      # 1 -> @column_width * 1 ,0
      # 2 -> @column_width * 2 ,0
      # 3 -> @column_width * 3 ,0
      #
      # 4 -> 0,1
      # 5 -> @column_width * 1 ,1
      # 6 -> @column_width * 2 ,1
      # 7 -> @column_width * 3 ,1
      #
      # 8 -> 0,1
      # 9 -> @column_width * 1 ,2
      # 10-> @column_width * 2 ,2
      # 11-> @column_width * 3 ,2
      #
      x = (pos.to_i % 4)*self.column_width.to_i
      y = (pos.to_i / 4)*self.column_height.to_i
      return x,y
    end

    #if x_count = 1 and y_count=1 it matches exactly 1 field
    #if x_count = 2 and y_count=1 it matches 2 x-neighboured fields
    #a.s.o
    def resize_picture(filename,x_count=1, y_count=1)
      x = self.column_width  * x_count
      y = self.column_height * y_count

      #puts "resizing to x,y: #{x}, #{y}"
      image = Magick.new(filename: filename)
      image.resize(x,y)
    end
  end
end
