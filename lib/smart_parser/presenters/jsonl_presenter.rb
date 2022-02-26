# frozen_string_literal: true

require 'json'

module SmartParser
  module Presenters
    # The JSONLPresenter implements a way to represent the output of the
    # Counter.to_a as JSONL.
    class JSONLPresenter
      class << self
        def present(rows, description)
          output = String.new

          rows.each do |line|
            json = JSON.dump({ path: line[0], visits: line[1], description: description })
            output << "#{json}\n"
          end

          output
        end
      end
    end
  end
end
