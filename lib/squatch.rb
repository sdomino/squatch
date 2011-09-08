
Dir["#{File.dirname(__FILE__)}/compressit/*"].each {|file| require(file)}

require 'optparse'

module Squatch
  class << self
  
    def run(arguments)
      options = Hash.new
      
      optparser = OptionParser.new do|opts|
        
        opts.banner = "Usage: squatch [option] [FOLDER] [VERSION]"

        opts.on('-h', '--help', 'Display this help') do
          puts optparser
        end
        opts.on('-v', '--version', 'Display current gem version') do
          puts "Currently using version: #{VERSION}"
        end
        opts.on('-c', '--css FOLDER VERSION', 'Squatch css files from [FOLDER] (in place)') do
          puts "Squatching css files in '#{arguments[0]}''"
          options[:folder], options[:version], options[:ext] = arguments[0], arguments[1], '.css'
          Squatch::Base.squatch(options)
        end
      end
      
      begin optparser.parse!(arguments)
      rescue OptionParser::InvalidOption => error
        puts "Oops! #{error}, try this: "
        puts optparser
        exit 1
      end
    end
  
  end
end

