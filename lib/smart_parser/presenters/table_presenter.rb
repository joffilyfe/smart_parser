# frozen_string_literal: true

require 'terminal-table'

module SmartParser
  module Presenters
    # The TablePresenter implements a way to represent the output of the
    # Counter.to_a using a Table compatible with terminals.
    class TablePresenter
      class << self
        def present(rows, description)
          Terminal::Table.new(title: description, headings: %w[Path Count], rows: rows).to_s
        end
      end
    end
  end
end
