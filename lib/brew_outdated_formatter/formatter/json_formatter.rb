require 'json'
require 'brew_outdated_formatter/formatter'

module BrewOutdatedFormatter
  # Formatter for JSON
  class JSONFormatter < Formatter
    def convert
      text = @pretty ? JSON.pretty_generate(@outdated_formulas) : @outdated_formulas.to_json
      text.chomp
    end
  end
end
