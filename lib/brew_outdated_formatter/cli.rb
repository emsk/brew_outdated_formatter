require 'thor'
require 'brew_outdated_formatter/error'
require 'brew_outdated_formatter/formatter/markdown_formatter'
require 'brew_outdated_formatter/formatter/json_formatter'

module BrewOutdatedFormatter
  # Command-line interface of {BrewOutdatedFormatter}
  class CLI < Thor
    FORMATTERS = {
      'markdown' => MarkdownFormatter,
      'json'     => JSONFormatter
    }.freeze

    default_command :output

    desc 'output', 'Format output of `brew outdated`'
    option :format, type: :string, aliases: '-f', default: 'markdown', desc: 'Format. (markdown, json)'
    option :pretty, type: :boolean, aliases: '-p', desc: '`true` if pretty output.'

    def output
      raise BrewOutdatedFormatter::UnknownFormatError, options[:format] unless allow_format?
      return if STDIN.tty?

      formatter = create_formatter
      formatter.read_stdin
      puts formatter.convert
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
