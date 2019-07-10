module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @route_params = {}
      end

      def match?(method, path)
        @method == method && check_path(path)
      end

      def params
        @route_params
      end

      private

      def check_path(path)
        path_array = @path.delete_prefix("/").split("/")
        user_path_array = path.delete_prefix("/").split("/")
        return false if path_array.size != user_path_array.size
        path_array.each_index do |i|
          if path_array[i][0].eql?(':')
            key = path_array[i].delete(':').to_sym
            @route_params[key] = user_path_array[i]
          else
            return false if path_array[i] != user_path_array[i]
          end
        end
      end

    end
  end
end
