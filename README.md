# CsvCutter

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/csv_cutter`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_cutter'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install csv_cutter

## Usage

### For Ruby

```ruby
csv = CsvCutter::Csv.new(
  headers: true,
  encoding: 'Shift_JIS:UTF-8',
  col_sep: ',',
  quote_char: '"',
  out_dir: 'output_dir',
)
csv.split_by_number_rows(file_path: 'file.csv', number_rows: 100)
```

### For CLI

```ruby
csv_cutter split_by_number_rows sample.csv output_dir --headers --encoding Shift_JIS:UTF-8 --col_sep , --quote_char '"' --number_rows 100
```

### Options
|option name|type|description|default_value|
|---|---|---|---|
|headers|boolean|Header flag|false|
|encoding|string|CSV encording|-|
|col_sep|string|Column separate char|`,`|
|quote_char|string|Quote char|`"`|
|out_dir|string|Output directory|required|
|number_rows|number|split number rows|10000|

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/csv_cutter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
