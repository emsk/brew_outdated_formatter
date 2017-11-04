require 'psych'
require 'brew_outdated_formatter/formatter'

module BrewOutdatedFormatter
  # Formatter for YAML
  class YAMLFormatter < Formatter
    def convert
      @outdated_formulas.to_yaml.chomp
    end
  end
end
