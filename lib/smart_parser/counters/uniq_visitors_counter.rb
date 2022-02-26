# frozen_string_literal: true

require 'set'
require_relative 'counter'

module SmartParser
  module Counters
    # Count the most visited path considering only uniq visitors
    class UniqVisitorsCounter < Counter
      # Parse the received line using the @line_regex and counts
      # how many times the parsed `path` was received considering only unique
      # visits.
      #
      # @returns true - when the line was correctly parsed and counted
      # @returns false - when the line does not matches with the line regex
      def count(line)
        match = @line_regex.match(line.strip)

        return false if match.nil?

        path = match[:path]

        @container[path] ||= Set.new
        @container[path] << match[:address]

        true
      end

      # Returns an Array ordered by the most accessed path to the least accessed one
      #
      # @returns Array
      def to_a
        @container.each.sort_by { |_k, v| v.size }.map { |k, v| [k, v.size] }.reverse
      end

      def description
        'Unique visitors'
      end
    end
  end
end
