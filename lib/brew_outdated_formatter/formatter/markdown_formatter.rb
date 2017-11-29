require 'brew_outdated_formatter/formatter'

module BrewOutdatedFormatter
  # Formatter for Markdown
  class MarkdownFormatter < Formatter
    HEADER = <<-EOS.freeze
| formula | installed | current | pinned |
| --- | --- | --- | --- |
    EOS

    def convert
      @outdated_formulas.map! do |formula|
        "| #{formula.values.join(' | ')} |".gsub(/  /, ' ')
      end

      (HEADER + @outdated_formulas.join("\n")).chomp
    end
  end
end
