module Simpler
  class View
    class PlainView
      
      def initialize(env)
        @env = env
      end

      def render(binding)
        ERB.new(template).result(binding)
      end

      private

      def template
        @env['simpler.template'][:plain]
      end

    end
    
  end
  
end
