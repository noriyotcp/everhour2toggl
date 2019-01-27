require 'thor'
require 'everhour2toggl/everhour'
require 'everhour2toggl/toggl'
require 'everhour2toggl/toggl/post'
require 'everhour2toggl/file_generator'

module Everhour2toggl
  class CLI < Thor
    option :from, type: :string, required: true, desc: 'Date from you what to fetch reported time (format YYYY-MM-DD) Example: 2018-01-01.'
    option :to, type: :string, required: true, desc: 'Date to you what to fetch reported time (format YYYY-MM-DD) Example: 2018-01-31.'
    option :fields, type: :string, desc: 'Comma separated objects to group by and fetch (allowed: user, project, task and date). Example: date,user,task.'
    option :apikey, type: :string, required: true, desc: 'API key for authorization'
    desc 'export', "Export Everhour's team time to json"
    def export
      everhour = Everhour.new(from: options[:from], to: options[:to], fields: options[:fields], apikey: options[:apikey])
      everhour.export
    end

    option :input, type: :string, required: true, desc: 'JSON file to convert /path/to/example.json'
    option :starting_time, type: :string, desc: 'Starting time on every entry Example: 10:00 NOTE: without this option, starting_time sets 00:00'
    option :interval, type: :numeric, desc: 'Time interval between entries Example: 60, default is 3600(1 hour)'
    option :wid, type: :numeric, desc: 'workspace ID (integer, required if pid or tid not supplied)'
    option :pid, type: :numeric, desc: 'project ID (integer, not required)'
    option :tags, type: :string, desc: 'Tags, separated by comma Example: foo,bar,baz'
    desc 'convert', "Convert Everhour time entries to JSON which supports Toggl time entries"
    def convert
      toggl = Toggl.new(input: options[:input], starting_time: options[:starting_time], interval: options[:interval], wid: options[:wid], pid: options[:pid], tags: options[:tags])
      toggl.convert
    end

    option :api_token, type: :string, required: true, desc: 'personal api token'
    option :input, type: :string, required: true, desc: 'JSON file to post /path/to/example.json'
    desc 'post', 'Post time entries to toggl'
    def post
      toggl_post = Toggl::Post.new(api_token: options[:api_token], input: options[:input])
      toggl_post.post
    end
  end
end
