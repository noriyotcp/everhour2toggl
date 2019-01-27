# Everhour2toggl

This gem exports [Everhour](https://everhour.com/)'s time entries, converts them to [Toggl](https://toggl.com/)'s time entries and posts them to Toggl.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'everhour2toggl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install everhour2toggl

## Usage

Export Everhour's time entries to JSON (default: `<pwd>/everhour_entries/<from>-<to>-<fields>.json`)

```sh
$ everhour2toggl export --from 2019-01-01 --to 2019-01-31 --apikey xxxx-xxxx-xxxxxx-xxxxxx-xxxxxxxx --fields date,task,user
```

Convert Everhour's time entries to Toggl's ones (JSON, default:`<pwd>/toggl_entries/<from>-<to>-<fields>.json`)

```sh
$ everhour2toggl convert --input everhour_entries/2019-01-01-2019-01-31-date,task,user.json --starting_time 10:00 --interval 60 --pid xxxxxxx --tags foo,bar,baz
```

Post Toggl's time entries to Toggl

```sh
$ everhour2toggl post --input toggl_entries/2019-01-01-2019-01-31-date,task,user.json --api_token <YOUR_API_TOKEN>
```

To see more usage

```sh
$ everhour2toggl (or with option -h)
```

This gem uses [Thor](https://github.com/erikhuda/thor) ([homepage](http://whatisthor.com/))

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/noriyotcp/everhour2toggl.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
