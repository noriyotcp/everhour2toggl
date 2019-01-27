require 'json'
require 'time'

module Everhour2toggl
  class Toggl
    def initialize(input:, starting_time:, interval: 3600, wid:, pid:, tags:)
      begin
        raise 'Error' unless pid || wid
      rescue => e
        puts "#{e}: wid must be required if pid is not supplied"
      end
      @input = input
      @starting_time = starting_time
      @interval = interval
      @wid = wid
      @pid = pid
      @tags = tags
    end

    def convert
      output_path = "toggl_entries"
      # output file name is same with input file
      file_generator = Everhour2toggl::FileGenerator.new(output: output_path, filename: "#{File.basename(@input)}")
      file_generator.generate(converted_str)
    end

    def converted_str
      file = File.read(@input)
      data = JSON.parse(file)
      groups = groups_by_date(data)
      bodies = groups.map do |group|
        request_bodies(group)
      end.flatten
      JSON.pretty_generate(bodies)
    end

    def groups_by_date(data)
      data.group_by { |d| d['date'] }
    end

    def request_bodies(group)
      # convert group[0](date) + starting_time to Time
      # e.g. 2019-01-04 10:00:00 +0900
      start = Time.parse([group[0], @starting_time].join(' '))
      entry_array = group[1]
      offset = 0
      request_bodies = []
      entry_array.each do |entry|
        request_bodies << { "time_entry":
                            {
                              "description": entry['task']['name'],
                              "wid": @wid,
                              "pid": @pid,
                              "duration": entry['time'],
                              "start": (start + offset).iso8601,
                              "created_with": "everhour2toggl",
                              "tags": @tags&.split(',')
                            }.compact
                          }
        offset += entry['time'] + @interval
      end
      request_bodies
    end
  end
end
