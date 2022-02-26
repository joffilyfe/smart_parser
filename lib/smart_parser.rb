# frozen_string_literal: true

require_relative 'smart_parser/version'
require_relative 'smart_parser/counters/counter'

module SmartParser
  # Regex to search for data separeted by a space
  LINE_REGEX = /(?<path>.*)\s+(?<address>.*)$/.freeze
end
