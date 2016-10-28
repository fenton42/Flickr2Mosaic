require 'optparse'

Options = Struct.new(:name)

class Parser
  def self.parse(options)
    args = Options.new("world")

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: example.rb [options]"

      opts.on("-tTAGLIST", "--name=TAGLIST", "List of tags, comma separated") do |n|
        args.name = t
      end

      opts.on("-oOUTPUT", "--output=OUTPUT", "path of the desired output file") do |o|
        args.name = o
      end
      
      opts.on("-iINPUTFILE", "--inputfile=INPUTFILE", "path of a backup keyword list file") do |i|
        args.name = i
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
