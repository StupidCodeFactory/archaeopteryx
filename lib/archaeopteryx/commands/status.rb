module Archaeopteryx
  module Commands
    class Status < Thor::Group

      def application
        @application || Archaeopteryx::Application.new
      end

      def log_application_status
        application.log_status
        exit(0)
      end
    end
  end
end
