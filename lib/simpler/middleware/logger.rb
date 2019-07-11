require 'logger'

module Simpler
  class AppLogger

    def initialize(app)
      @log = Logger.new(log_file)
      @app = app
    end
  
    def call(env)
      @status, @headers, body = @app.call(env)
      add_log(env)
      [@status, @headers, body]      
    end

    private

    def log_path
      'log/'
    end
  
    def log_file
      Simpler.root.join(log_path, "app.log")
    end
  
    def add_log(env)
      controller = env["simpler.controller"]
      action = env["simpler.action"]
      str = ''
      str = <<~LOG
        Request: #{env["REQUEST_METHOD"]} #{env["PATH_INFO"]}
        Parameters: #{controller.nil? ? 'No' : controller.request.params}
        #{handler_info(controller, action)}
        #{response_info(env["simpler.template"], controller, action)}
      LOG
        
      @log.info str
    end

    def handler_info(controller, action)
      if controller.nil?
        "Handler: No"
      else
        "Handler: #{controller.name.capitalize}Controller##{action}"
      end
    end

    def response_info(template, controller, action)
      status = @status
      header = @headers['Content-Type']
      path = if template.nil? && !controller.nil?
              "#{controller.name}/#{action}.html.erb"
            else
              ''
            end
      "Response: #{status} #{header} #{path}"
    end
  
  end
  
end
