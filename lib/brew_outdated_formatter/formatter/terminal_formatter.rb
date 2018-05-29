require 'tty-table'
require 'brew_outdated_formatter/formatter'

module BrewOutdatedFormatter
  # Formatter for Terminal
  class TerminalFormatter < Formatter
    def convert
      table = TTY::Table.new(header: COLUMNS) do |t|
        @outdated_formulas.each do |formula|
          t << formula.values
        end
      end
      table.render(@style.to_sym, padding: [0, 1]).chomp
    end
  end
end
