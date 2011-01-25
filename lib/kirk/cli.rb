require 'kirk'
require 'optparse'

module Kirk
  class CLI
    def self.start(argv)
      new(argv).tap { |inst| inst.run }
    end

    def initialize(argv)
      @argv    = argv.dup
      @options = default_options
    end

    def run
      parse!

      server = Kirk::Server.build(config)
      server.start
      server.join
    rescue Exception => e
      abort "[ERROR] #{e.message}"
    end

  private

    def config
      @options[:config]
    end

    def default_options
      { :config => "#{Dir.pwd}/Kirkfile" }
    end

    def parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = "Usage: kirk [options] <command> [<args>]"

        opts.separator ""
        opts.separator "Server options:"

        opts.on("-c", "--config FILE",  "Load options from a config file") do |file|
          @options[:config] = file
        end
      end
    end

    def parse!
      parser.parse! @argv
    end
  end
end
