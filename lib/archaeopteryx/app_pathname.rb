require 'pathname'
require 'archaeopteryx/cli'
module Archaeopteryx
  class AppPathname < Pathname
    def valid?
      true
    end

    def connections_file
      config_dir.join(Archaeopteryx::Commands::New::CONNECTIONS)
    end

    def log_file
      join(Archaeopteryx::CLI::LOG_DIR).join('arcx.log')
    end

    def instrument_files
      Dir["#{instruments_dir}/**/*.rb"]
    end

    def clip_files
      Dir["#{clips_dir}/**/*.rb"]
    end

    def pid_file
      pid_dir
        .join('arcx.pid')
    end

    def pid_dir
      tmp_dir.join('pids')
    end

    def tmp_dir
      join('tmp')
    end

    def config_dir
      join('config')
    end

    def clips_dir
      join(Archaeopteryx::CLI::CLIPS_DIR)
    end

    def instruments_dir
      join(Archaeopteryx::CLI::INSTRUMENTS_DIR)
    end
  end
end
