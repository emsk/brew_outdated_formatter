require 'csv'
require 'brew_outdated_formatter/formatter'

module BrewOutdatedFormatter
  # Formatter for CSV
  class CSVFormatter < Formatter
    def convert
      text = CSV.generate(force_quotes: true) do |csv|
        csv << COLUMNS
        @outdated_formulas.each do |formula|
          csv << formula.values
        end
      end
      text.chomp
    end
  end
end
