module BrewOutdatedFormatter
  # Formatter for all formats
  class Formatter
    FORMULA_REGEXP   = /\A(?<formula>.+) \(/
    INSTALLED_REGEXP = /\((?<installed>.+)\)/
    CURRENT_REGEXP   = /< ((?<current>.+) \[|(?<current>.+)\z)/
    PINNED_REGEXP    = /\[pinned at (?<pinned>.+)\]/

    COLUMNS = %w[formula installed current pinned].freeze

    def initialize(options)
      @pretty = options[:pretty]
      @style = options[:style]
      @outdated_formulas = []
    end

    def read_stdin
      @outdated_formulas = STDIN.each.to_a.map(&:strip).reject(&:empty?)

      @outdated_formulas.map! do |line|
        find_formula(line)
      end

      @outdated_formulas.compact!
    end

    private

    def find_formula(line)
      matched = match_formula(line)
      return unless match_formula?(matched)

      {
        'formula'   => formula_text(matched[:formula], :formula),
        'installed' => formula_text(matched[:installed], :installed),
        'current'   => formula_text(matched[:current], :current),
        'pinned'    => formula_text(matched[:pinned], :pinned)
      }
    end

    def match_formula(line)
      {
        formula:   FORMULA_REGEXP.match(line),
        installed: INSTALLED_REGEXP.match(line),
        current:   CURRENT_REGEXP.match(line),
        pinned:    PINNED_REGEXP.match(line)
      }
    end

    def match_formula?(matched)
      COLUMNS.any? do |column|
        !matched[column.to_sym].nil?
      end
    end

    def formula_text(text, name)
      text ? text[name] : ''
    end

    def xml_formatter
      return REXML::Formatters::Default.new unless @pretty

      formatter = REXML::Formatters::Pretty.new
      formatter.compact = true
      formatter
    end
  end
end
