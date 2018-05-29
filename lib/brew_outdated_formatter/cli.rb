require 'thor'
require 'brew_outdated_formatter/error'
require 'brew_outdated_formatter/formatter/terminal_formatter'
require 'brew_outdated_formatter/formatter/markdown_formatter'
require 'brew_outdated_formatter/formatter/json_formatter'
require 'brew_outdated_formatter/formatter/yaml_formatter'
require 'brew_outdated_formatter/formatter/csv_formatter'
require 'brew_outdated_formatter/formatter/tsv_formatter'
require 'brew_outdated_formatter/formatter/xml_formatter'
require 'brew_outdated_formatter/formatter/html_formatter'

module BrewOutdatedFormatter
  # Command-line interface of {BrewOutdatedFormatter}
  class CLI < Thor
    FORMATTERS = {
      'terminal' => TerminalFormatter,
      'markdown' => MarkdownFormatter,
      'json'     => JSONFormatter,
      'yaml'     => YAMLFormatter,
      'csv'      => CSVFormatter,
      'tsv'      => TSVFormatter,
      'xml'      => XMLFormatter,
      'html'     => HTMLFormatter
    }.freeze
    STYLES = %w[unicode ascii].freeze

    default_command :output

    desc 'output', 'Format output of `brew outdated --verbose`'
    option :format, type: :string, aliases: '-f', default: 'terminal', desc: 'Format. (terminal, markdown, json, yaml, csv, tsv, xml, html)'
    option :pretty, type: :boolean, aliases: '-p', desc: '`true` if pretty output.'
    option :style, type: :string, aliases: '-s', default: 'unicode', desc: 'Terminal table style. (unicode, ascii)'

    def output
      raise BrewOutdatedFormatter::UnknownFormatError, options[:format] unless allow_format?
      raise BrewOutdatedFormatter::UnknownStyleError, options[:style] unless allow_style?
      return if STDIN.tty?

      formatter = create_formatter
      formatter.read_stdin
      puts formatter.convert
    end

    desc 'version, -v, --version', 'Print the version'
    map %w[-v --version] => :version

    def version
      puts "brew_outdated_formatter #{BrewOutdatedFormatter::VERSION}"
    end

    private

    def allow_format?
      FORMATTERS.key?(options[:format])
    end

    def allow_style?
      STYLES.include?(options[:style])
    end

    def create_formatter
      FORMATTERS[options[:format]].new(options)
    end
  end
end
