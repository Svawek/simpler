require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      if template_type == 'hash'
        template = create_template
      else
        template = File.read(template_path)
      end

      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template_type
      @env['simpler.template_type']
    end
  

    def template_path
      path = template || [controller.name, action].join('/')

      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

    def create_template
      hash = template
      text = ''
      hash.each do |k,v|
        if k == :plain || :inline
          text << v
        end
      end
      text
    end

  end
end
