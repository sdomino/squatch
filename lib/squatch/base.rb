module Squatch
  module Base
    class << self

      require 'fileutils'

      def squatch(options)

        destination_path = Dir.open(File.dirname(options[:data]))

        case File.ftype(options[:data])
        when 'file'
          files_to_squatch = Array[options[:data]]
          backup_dir = "#{File.dirname(options[:data])}/backup"
        when 'directory'
          files_to_squatch = Dir.glob("#{options[:data]}/**/*#{options[:ext]}")
          backup_dir = "#{options[:data]}/backup"
        else
          puts "Oops!"
          exit
        end

        Dir.exists?(backup_dir) ? true : Dir.mkdir(backup_dir)
        
        # squatch each file in files_to_compress and save in place
        begin
          files_to_squatch.each do |path|            
            File.open("#{path}", 'r+') do |file|
              
              FileUtils.copy_file(file, "#{backup_dir}/#{File.basename(file, File.extname(file))}.txt")
              puts "Backup of #{File.basename(file)} created at #{backup_dir} named #{File.basename(file, File.extname(file))}.txt."
              
              new_lines = ''

              puts "Squatching: #{File.basename(file)}..."
              file.each_line do |line|
                new_lines.concat(line.strip)
              end

              new_lines.gsub!(';', '; ')
              new_lines.gsub!('{', '{ ')
              new_lines.gsub!('}', "}\n")
              new_lines.gsub!('/*', "\n/*")
              new_lines.gsub!('*/', "*/\n")

              # new_lines.each_char do |char|
              #   case char
              #   when ';'
              #     puts "SEMI: #{char}, #{char.class}"
              #     char.replace('HELLO')
              #   else
              #   end
              # end

              file.rewind
              file.print(new_lines)
              file.truncate(file.pos)

            end

            puts "#{File.basename(path)} has been squatched"
          end
          
          # confirm squatching
          puts "Complete! All #{options[:ext]} files have been squatched"
        rescue => exception
          puts "Oops! #{exception.message}"
          exception.backtrace.each do |trace|
            puts "#{trace} \n"
          end
        end
      end

      # this will save a version of their file somewhere incase they decide they don't want it squatched anymore. Much easier than actually trying to add all the whitespace back in.
      def unsquatch(options)

      end
      
    end
  end
end
