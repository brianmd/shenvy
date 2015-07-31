[![Gem Version](https://badge.fury.io/rb/shenvy.png)](http://badge.fury.io/rb/shenvy)

# Shenvy

This gem loads the environment created by a shelscript into Ruby's ENV hash.

The genesis of this is the need to load .envrc files (used by direnv) into RubyMine.
It has the same concept as the dotenv and figaro gems, but for arbitrarily complex shell scripts.

An example of where I use this is opting different services when at work vs away from work.

```sh
# local, dev, or prod
DATABASE=local
REDIS=dev
# ...


if [ $DATABASE == "dev" ]; then
  export BLUE_HARVEST_HOST=mysql.dev
  export BLUE_HARVEST_DATABASE=blue_harvest_dev
elif [ $DATABASE == "local" ]; then
  export BLUE_HARVEST_HOST=localhost
  export BLUE_HARVEST_DATABASE=blue_harvest_dev
elif [ $DATABASE == "prod" ]; then
  export BLUE_HARVEST_HOST=mysql.prod
  export BLUE_HARVEST_DATABASE=blue_harvest_production
else
  echo
  echo "ERROR: DATABASE was not set."
  echo
  exit 1
fi

if [ $REDIS == "dev" ]; then
# ...
fi
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shenvy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shenvy

## Usage

```ruby
require 'shenvy'
Shenvy.load(Pathname.new(__FILE__).dirname.parent + '.env')

note: this will be shortened to 'Shenvy.load' in the near future.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/shenvy.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

