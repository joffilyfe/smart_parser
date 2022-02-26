# frozen_string_literal: true

module SmartParser
  module Counters
    # This is a super class which difines what other counters
    # must implements. Every counter which inherance from this
    # class will use the Hash as data container to store information
    # about parsed lines.
    #
    # Every counter must implements the `to_a` method and it should
    # return an array ordered from the most relevant to the least relevant.
    #
    class Counter
      def initialize(container: {}, line_regex: SmartParser::LINE_REGEX)
        @container = container
        @line_regex = line_regex
      end

      def count(line)
        raise NotImplementedError
      end

      # Returns an Array containing Arrays with two positions inside
      def to_a
        raise NotImplementedError
      end

      # Returns the description for the Counter
      #
      # @returns String
      def description
        raise NotImplementedError
      end
    end
  end
end
