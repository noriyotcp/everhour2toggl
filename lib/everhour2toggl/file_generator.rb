require 'fileutils'

module Everhour2toggl
  class FileGenerator
    def initialize(output:, filename:)
      @output = output
      @filename = filename
    end

    def generate(str)
      FileUtils.mkdir_p("#{@output}")
      File.open("#{Dir.pwd}/#{@output}/#{@filename}", "w") do |file|
        file.puts(str)
      end
    end
  end
end
