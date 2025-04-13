# JokeApi

API Client for [Official Joke API](https://github.com/15Dkatz/official_joke_api).

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/joke_api`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add joke_api
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install joke_api
```

## Usage

```ruby
client = JokeApi::Client.new # => #<JokeApi::Client:0x00007f2fc989d960>

client.random_joke # =>
#<JokeApi::Client::JokeResponse:0x00007f2fc97b4b20
 @id=415,
 @punchline="He didn't know how to commit.",
 @setup="Why did the programmer's wife leave him?",
 @type="programming">
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/joke_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/joke_api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JokeApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/joke_api/blob/main/CODE_OF_CONDUCT.md).
