# frozen_string_literal: true

module SmartParser
  module Presenters
    # The LinePresenter implements a way to represent the output of the
    # Counter.to_a as a simple lines showing the number of visits.
    # Every path + visits will be treat as a line for the output.
    class LinePresenter
      class << self
        def present(rows, description)
          output = String.new("#{description}\n")

          rows.each do |line|
            output << "#{line[0]} #{line[1]} visits\n"
          end

          output
        end
      end
    end
  end
end
