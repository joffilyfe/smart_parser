# frozen_string_literal: true

require_relative 'counter'

module SmartParser
  module Counters
    # Count the most visited path
    class MostVisitedCounter < Counter
      # Parse the received line using the @line_regex and counts
      # how many times the parsed `path` was received.
      #
      # @returns true - when the line was correctly parsed and counted
      # @returns false - when the line does not matches with the line regex
      def count(line)
        match = @line_regex.match(line.strip)

        return false if match.nil?

        path = match[:path]

        if @container[path].nil?
          @container[path] = 1
        else
          @container[path] += 1
        end

        true
      end

      # Returns an Array ordered by the most accessed path to the least accessed one
      #
      # @returns Array
      def to_a
        @container.each.sort_by { |_k, v| v }.reverse.to_a
      end

      def description
        'Most visited'
      end
    end
  end
end
