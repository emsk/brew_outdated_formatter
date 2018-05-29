require 'rexml/document'
require 'brew_outdated_formatter/formatter'

module BrewOutdatedFormatter
  # Formatter for XML
  class XMLFormatter < Formatter
    def initialize(options)
      super(options)

      @xml = REXML::Document.new(nil, raw: :all)
      @root = REXML::Element.new('formulas')
      @root.add_text('')
      @xml.add_element(@root)
    end

    def convert
      @outdated_formulas.each do |formula|
        add_outdated(formula)
      end

      io = StringIO.new
      io.write('<?xml version="1.0" encoding="UTF-8"?>')
      io.write("\n") if @pretty
      xml_formatter.write(@xml, io)
      io.string.chomp
    end

    private

    def add_outdated(formula)
      elements = @root.add_element(REXML::Element.new('outdated'))

      COLUMNS.each do |column|
        elements.add_element(column).add_text(formula[column])
      end
    end
  end
end
