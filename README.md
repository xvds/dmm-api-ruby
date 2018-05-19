# Dmm

DMM API Client for ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dmm', github: 'xvds/dmm-api-ruby', tag: 'v0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install specific_install
    $ gem specific_install xvds/dmm-api-ruby

## Usage

```ruby
# Provide authentication credentials
Dmm.configure do |c|
  c.api_id = 'YOUR_API_ID'
  c.affiliate_id = 'YOUR_AFFILIATE_ID'
end

# Fetch items
Dmm.items(site: 'DMM.com')
```
or

```ruby
client = Dmm::Client.new(api_id: 'YOUR_API_ID', affiliate_id: 'YOUR_AFFILIATE_ID')
client.items(site: 'DMM.com')
```

## Examples

### 商品情報API

```ruby
res = Dmm.items(site: 'DMM.com')
p res.elements

# pagination
Dmm.paginate_items(site: 'DMM.com', paginate_count: 10) do |res|
  p res.meta
end
```

### フロアAPI

```ruby
res = Dmm.site
p res.elements
```

### 女優検索API

```ruby
res = Dmm.actress
p res.elements

# pagination
Dmm.paginate_actress(paginate_count: 10) do |res|
  p res.meta
end
```

### ジャンル検索API

```ruby
res = Dmm.genre(floor_id: 25)
p res.elements
```

### メーカー検索API

```ruby
res = Dmm.maker(floor_id: 25)
p res.elements
```

### シリーズ検索API

```ruby
res = Dmm.series(floor_id: 25)
p res.elements
```

### 作者検索API

```ruby
res = Dmm.author(floor_id: 25)
p res.elements
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xvds/dmm-api-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
