module Flickr2Mosaic
  class CLI
    def self.start(params=[])
      begin
      args = Parser.parse(params)
      #puts args.to_yaml
      Processing.new(
        output: args[:output],
        tags: args[:tags].split(/,/),
        filename: args[:taglist]
      ).perform
      rescue Exception => e
        STDERR.puts e.message
        exit 1
      end
    end
  end
end
