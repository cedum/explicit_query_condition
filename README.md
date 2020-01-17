# Explicit Query Condition

Enforce an explicit query condition by showing a warning when the enforced
column is missing from the condition.

**WARNING: this is an experimental extension and still in a very early stage of
development.**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'explicit_query_condition', github: 'cedum/explicit_query_condition'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install explicit_query_condition

## Usage

**Include the extension in a model**

```ruby
class Post < ActiveRecord::Base
  include ExplicitQueryCondition::ModelExtension

  # define the column you want to be present in all queries
  self.explicit_condition_column = :deleted_at
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cedum/explicit_query_condition.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## About

[![Nebulab][nebulab-logo]][nebulab]

`explicit_query_condition` is funded and maintained by the [Nebulab][nebulab] team.

We firmly believe in the power of open-source. [Contact us][contact-us] if you
like our work and you need help with your project design or development.

[solidus]: http://solidus.io/
[nebulab]: http://nebulab.it/
[nebulab-logo]: http://nebulab.it/assets/images/public/logo.svg
[contact-us]: http://nebulab.it/contact-us/
