require 'csv'
require 'brew_outdated_formatter/formatter'

module BrewOutdatedFormatter
  # Formatter for TSV
  class TSVFormatter < Formatter
    def convert
      text = CSV.generate(force_quotes: true, col_sep: "\t") do |tsv|
        tsv << COLUMNS
        @outdated_formulas.each do |formula|
          tsv << formula.values
        end
      end
      text.chomp
    end
  end
end
