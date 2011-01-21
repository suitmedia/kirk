require 'kirk'
require 'optparse'

module Kirk
  class CLI
    def self.start(argv)
      new(argv).tap { |inst| inst.run }
    end

    def initialize(argv)
      @argv    = argv.dup
      @options = {}
    end

    def run
      parse!
    end

  private

    def parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: kirk [options] <command> [<args>]"

        opts.separator ""
      end
    end

    def parse!
      parser.parse! @argv
    end
  end
end
