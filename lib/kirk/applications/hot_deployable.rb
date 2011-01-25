require 'digest/sha1'

module Kirk
  module Applications
    # This class extends a native Java class
    class HotDeployable < Native::HotDeployableApplication

      def initialize(config)
        super

        redeploy
      end

      def key
        path = "#{application_path}/Gemfile.lock"
        if File.exist?(path)
          Digest::SHA1.hexdigest(File.read(path))
        end
      end

      def add_watcher(watcher)
        add_life_cycle_listener(watcher)
      end

      def application_path
        config.application_path
      end

      def last_modified
        mtimes = config.watch.map do |path|
          path = File.expand_path(path, application_path)
          File.exist?(path) ? File.mtime(path).to_i : 0
        end

        mtimes.max
      end

      def redeploy
        deploy(build_deploy.tap { |d| d.prepare })
      end
    end
  end
end
