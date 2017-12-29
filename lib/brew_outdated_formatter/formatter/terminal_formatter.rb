require 'terminal-table'
require 'brew_outdated_formatter/formatter'

module BrewOutdatedFormatter
  # Formatter for Terminal
  class TerminalFormatter < Formatter
    def convert
      table = Terminal::Table.new do |t|
        t << COLUMNS
        t << :separator
        @outdated_formulas.each do |formula|
          t << formula.values
        end
      end
      table.render.chomp
    end
  end
end
