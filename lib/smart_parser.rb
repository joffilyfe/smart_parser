# frozen_string_literal: true

require_relative 'smart_parser/version'
require_relative 'smart_parser/counters/counter'
require_relative 'smart_parser/counters/most_visited_counter'
require_relative 'smart_parser/counters/uniq_visitors_counter'
require_relative 'smart_parser/presenters/line_presenter'
require_relative 'smart_parser/presenters/table_presenter'
require_relative 'smart_parser/presenters/jsonl_presenter'

module SmartParser
  # Regex to search for data separated by a space
  LINE_REGEX = /(?<path>.*)\s+(?<address>.*)$/.freeze

  # By default the MostVisitedCounter and UniqVisitorsCounter
  # will be used to parse lines.
  DEFAULT_COUNTERS = [
    Counters::MostVisitedCounter.new,
    Counters::UniqVisitorsCounter.new
  ].freeze

  # By default the LinePresenter will be used to display
  # the results of the Parser.
  DEFAULT_PRESENTER = Presenters::LinePresenter

  # The Parser class join every piece of the gem and expose the
  # results of the Counters and Presenters selected during its
  # initialization.
  #
  # During the construction of a new Parse instance you must
  # inject the lines that you want to parse. Also, you can select
  # your own Counter and your own Presenter.
  #
  # ==== Attributes
  # +lines+ - An Array containing strings to be parsed
  # +counters+ - An Array containing zero or many Counter's.
  # +presenter+ - A Presenter which will be used to displays the parser result.
  #
  # ==== Examples
  # # Creates a new Parser with only one Counter and with JSONLPresenter
  # p = Parser.new(
  #      lines: ['/a 127.8.8.1'],
  #      counters: [SmartParser::Counters::UniqVisitorsCounter]
  #      presenter: SmartParser::Presenters::JSONLPresenter
  # )
  # # Now you should parse! and show the results
  # p.parse!
  # p.present
  #
  class Parser
    attr_reader :lines
    attr_accessor :presenter

    def initialize(lines: [], counters: DEFAULT_COUNTERS, presenter: DEFAULT_PRESENTER)
      @lines = lines
      @counters = counters
      @presenter = presenter
      @parsed = false
    end

    # Verify all @lines and uses the defined counters to generate
    # metrics about the log lines. It runs only once.
    # If lines were parsed successfully it will returns true
    # otherwise false.
    #
    # @returns bool
    def parse!
      return false if @counters.empty? || @lines.empty? || parsed?

      @lines.each do |line|
        @counters.each do |counter|
          counter.count(line.strip)
        end
      end

      parsed!

      true
    end

    # Returns an Array containing data for every selected Counter.
    #
    # returns @array
    def counters_results
      @counters.map { |counter| { description: counter.description, data: counter.to_a } }
    end

    # Shows the parsed result using the selected Presenter.
    # Note: the result will be displayed using the stdout
    #
    # @returns nil
    def present
      return if @presenter.nil?

      @counters.each do |counter|
        puts @presenter.present(counter.to_a, counter.description)
        puts "\n"
      end
      nil
    end

    # Checks if the parser already ran.
    #
    # @returns bool
    def parsed?
      @parsed
    end

    private

    def parsed!
      @parsed = true
    end
  end
end
