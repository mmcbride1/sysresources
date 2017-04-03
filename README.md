# Sysresources

'sysresources' is a simple command line tool that prints the following system resources statistics to the screen: disk, ram, percent cpu used, system uptime and running processes.  This tool is constructed for linux systems only. There is nothing too special about this gem, but it does organize the above information into one place and eliminates the need to run numerous system commands.    
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sysresources'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sysresources

## Usage

simply run 'sysresources' at the command line. may be a good idea to alias this command as 'stats' or 'system' to make things shorter.      

legend: 

disk(G):             remaining disk space on "/home" partition. Defaults to reading "/" if "/home" not found.
ram(G):              memory AVAILABLE    
cpu(%):              percent cpu being spent at current point in time     
uptime(s/m/h/d):     system uptime    
process(#):          number of running processes    

example output:

[ gb-i75930k current ]

 xxxxxxxxx disk:370G
 xxxxxxxxx ram:27G
 xxxxxxxxx cpu:2.67%
 xxxxxxxxx uptime:3 days
 xxxxxxxxx process:278

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sysresources. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

