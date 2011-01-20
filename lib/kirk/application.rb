module Kirk
  # This class extends a native Java class
  class Application
    def self.build(path, opts = {})
      config = ApplicationConfig.new
      config.set_application_path path.to_s
      config.set_bootstrap_path File.expand_path('../bootstrap.rb', __FILE__)
      new(config)
    end

    def self.new(config)
      super.tap { |i| i.spawn_watcher_thread }
    end

    def application_path
      config.application_path
    end

    def spawn_watcher_thread
      @thread = Thread.new do
        last_modified = check_last_modified

        loop do
          sleep 0.1
          mtime = check_last_modified

          if mtime > last_modified
            reload_deploy
            last_modified = mtime
          end
        end
      end
    end

  private

    def check_last_modified
      path = "#{application_path}/REVISION"

      return 0 unless File.exist?(path)

      File.mtime(path).to_i
    end
  end
end
