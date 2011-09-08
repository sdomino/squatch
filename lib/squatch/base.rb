module Squatch
  module Base
    class << self

      require 'fileutils'
      require 'tempfile'

      def squatch(options)
        @version, @ext, @folder  = options[:version], options[:ext], options[:folder]
        
        @destination_path, @files_to_squatch = Dir.open("#{@folder}"), Dir.glob("#{@folder}/**/*#{@ext}")
        
        # squatch each file in @files_to_compress and save in place
        begin

          @files_to_squatch.each do |file|
            backup = Tempfile.new("#{file}.txt")
            FileUtils.mv('/tmp', backup)

            puts "Squatching: #{File.basename(file)}..."
            
            tmp = Tempfile.new("tmp.txt")
            File.open("#{file}", 'r') do |file|
              file.each_line{|line| tmp.puts line.strip}
            end
            FileUtils.mv(tmp, '#{file}.txt')
            
            # File.read(file, 'w').each do |line|
            #   file.puts line.strip
            # end
            puts "#{File.basename(file)} has been squatched"
          end
          
          # confirm squatching
          puts "Complete! All #{@ext} files have been squatched"
        rescue
          puts "Hmm... looks like this folder doesn't contain any #{@ext} files."
        end
      end

      # this will save a version of their file somewhere incase they decide they don't want it squatched anymore. Much easier than actually trying to add all the whitespace back in.
      def unsquatch(options)

      end
      
    end
  end
end
