require 'optparse'

Options = Struct.new(:tags, :output, :taglist, :secretfile)

class Parser
  def self.parse(options)
    args = Options.new("world")

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: example.rb [options]"

      opts.on("-tTAGS", "--tags=TAGS", "List of tags, comma separated") do |t|
        args.tags = t
      end

      opts.on("-oOUTPUT", "--output=OUTPUT", "path of the desired output file") do |o|
        args.output = o
      end
      
      opts.on("-lTAGLISTFILE", "--taglist=TAGLISTFILE", "path of a backup keyword list file") do |l|
        args.taglist = l
      end
      
      opts.on("-sSECRETFILE", "--secret=SECRETFILE", "path of the flickr credentials") do |s|
        args.taglist = s
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end
#options = Parser.parse %w[--help]

#=>
   # Usage: example.rb [options]
   #     -n, --name=NAME                  Name to say hello to
   #     -h, --help                       Prints this help
