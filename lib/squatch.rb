Dir["#{File.dirname(__FILE__)}/squatch/**/*"].each {|file| require(file)}

require 'optparse'

module Squatch
  class << self
  
    def run(arguments)
      unless arguments.empty? || !arguments[0].include?('-')
        optparser = OptionParser.new do|opts|
          opts.banner = "Usage: squatch -command [FILE/DIR]"

          opts.on('-h', '--help', 'Display this help') do
            puts optparser
            exit
          end
          opts.on('-v', '--version', 'Display current gem version') do
            puts "Squatch-#{VERSION}"
          end
          opts.on('-f', '--file FILE', 'Squatch FILE in place') do |file|
            prepare(file)
          end
          opts.on('-F', '--folder DIR', 'Squatch files from DIR in place') do |dir|
            prepare(dir)
          end
        end
        
        begin optparser.parse!(arguments)
        rescue OptionParser::ParseError => error
          puts "#{error}"
          puts optparser
          exit
        end
      else
        puts `squatch -h`
      end
    end

    def prepare(data)
      options = Hash[:data, data]

      puts "Specify file type (ie css or js):"
      options[:ext] = gets.strip

      Squatch::Base.squatch(options)
    end
  
  end
end

