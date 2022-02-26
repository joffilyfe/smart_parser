# SmartParser

This project aims to provide a _smart_ and easy way to parse any webserver log and print its results in a human-friendly format. It was designed with flexibility in mind. It makes it simple to change parts like Counters and Presenters.

## Design decisions

```ascii
          ┌────────────────────────────┐
          │                            ├────┐
   ┌──────┤          The User          │    │
   │      │                            │    │
   │      └─────────────▲──────────────┘    │
   │                    │                   │
   │                    │                   │
   │                    │                   │
   │         ┌──────────┴─────────┐         │
   │         │                    │         │
   │         │                    │         │
   │      ┌─►│       Parser       │◄─┐      │
   │      │  │                    │  │      │
   │      │  │                    │  │      │
   │      │  └────────────────────┘  │      │
   │      │                          │      │
   │      │                          │      │
   │      │                          │      │
   │      │                          │      │
   ▼      │                          │      ▼
 ┌────────┴───────────┐    ┌─────────┴──────────┐
 │                    │    │                    │
 │                    │    │                    │
 │      Counter       │    │     Presenter      │
 │                    │    │                    │
 │                    │    │                    │
 └────────────────────┘    └────────────────────┘

```

The above diagram shows how the `Parser` can be used by the user. The `Parser` class requires two moving parts: A list of `Counter` and a `Presenter`. By default, the gem has two counters (`MostVisitedCounter` and `UniqVisitorsCounter`), and many presenters see [here](https://github.com/joffilyfe/smart_parser/tree/main/lib/smart_parser/presenters).

This design allows the user to change any required parts and create their parts. It's easier to create a new Counter or even a new Presenter, just following the signature for them.

The default counters use a `Hash` as a container for the parsed lines, it allows us to access the paths with an O(1) access time. Also, the output of counters returns the sorted array with results, it uses the Ruby Quicksort algorithm which in the worst case will do the sort with O(n^2) but on the avg, it sorts using the O(n log n) [not too bad].

Using the `Presenter` not coupled with the `Parser` or even the `Counter` allows us to implement new parsers easily, it should not take more than five minutes.

## Installation

To use it in your application you should add this line to your Gemfile:

```ruby
gem 'smart_parser'
```

And then execute:

```bash
$ bundle install
```

Or, you can install it by yourself running this command:

```bash
$ gem install smart_parser
```

## Usage

You have two ways to use this gem:
1. As binary directly in your $PATH
2. As library loaded into your project

### Using as binary

Consider that you already installed the gem using the `gem install` method and installed it on your `lib` of the Ruby.

So, you can just run the following command:

```shell
$ sparser webserver.log
```

It includes a binary that has all Counters and Presenters and also includes additional options, to check run:

```shell
$ sparser -h
```

*Note*: You should take a look at the variety of `Presenters`. Try the `JSONL` for instance.

### Usage bonus

[![asciicast](https://asciinema.org/a/bs9adjgKAVeEmcjfFsExdcgg1.svg)](https://asciinema.org/a/bs9adjgKAVeEmcjfFsExdcgg1)

### Using as library

This is the second way to use the gem. You can just require (`require 'smart_parser'`) and starts using the classes like:

```ruby
parser = SmartParser::Parser.new(lines: ['/home 127.0.01'])
```

To have more details about this use, please check the code of the binary included in the gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joffilyfe/smart_parser.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
