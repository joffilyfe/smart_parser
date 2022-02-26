# frozen_string_literal: true

require_relative 'smart_parser/version'
require_relative 'smart_parser/counters/counter'
require_relative 'smart_parser/counters/most_visited_counter'
require_relative 'smart_parser/counters/uniq_visitors_counter'
require_relative 'smart_parser/presenters/line_presenter'
require_relative 'smart_parser/presenters/table_presenter'
require_relative 'smart_parser/presenters/jsonl_presenter'

module SmartParser
  # Regex to search for data separeted by a space
  LINE_REGEX = /(?<path>.*)\s+(?<address>.*)$/.freeze
end
