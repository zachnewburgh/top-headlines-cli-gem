# TopHeadlines

This gem allows users to view the top headlines from major news sources. Users can open the headlines directly from the command line. Functionality includes: BBC, Bloomberg, CNN, FiveThirtyEight, Forbes, Fox News, The Guardian, Huffington Post, MSNBC, New York Times, Politico, Wall Street Journal, and Washington Post.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'top-headlines'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install top-headlines

## Usage

In lib/top-headlines/source.rb, users will find a SOURCES hash. Users may add their own favorite news sources to the hash, so that the gem dynamically scrapes even more headlines.
```
If you'd like to view how I made the gem, here's a set of videos that captures almost all of it:
  1) https://drive.google.com/file/d/0B-xsMiWmDyyzcGk3MmlTc0xQOXM/view?usp=sharing
  2) https://drive.google.com/file/d/0B-xsMiWmDyyzNDFyS01icFMtams/view?usp=sharing
  3) https://drive.google.com/file/d/0B-xsMiWmDyyzU0VGNGJ5QkpaOUU/view?usp=sharing
  4) https://drive.google.com/file/d/0B-xsMiWmDyyzbEdzX0ZlOVcwM2M/view?usp=sharing
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zachnewburgh/top-headlines-cli-gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

