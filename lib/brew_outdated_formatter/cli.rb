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

    default_command :output

    desc 'output', 'Format output of `brew outdated`'
    option :format, type: :string, aliases: '-f', default: 'terminal', desc: 'Format. (terminal, markdown, json, yaml, csv, tsv, xml, html)'
    option :pretty, type: :boolean, aliases: '-p', desc: '`true` if pretty output.'

    def output
      raise BrewOutdatedFormatter::UnknownFormatError, options[:format] unless allow_format?
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
      FORMATTERS.keys.include?(options[:format])
    end

    def create_formatter
      FORMATTERS[options[:format]].new(options)
    end
  end
end
