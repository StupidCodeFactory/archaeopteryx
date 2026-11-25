module Archaeopteryx
  module Commands
    class Stop < Thor::Group

      def application
        @application || Archaeopteryx::Application.new
      end

      def stop
        application.stop
        exit(0)
      end
    end
  end
end
