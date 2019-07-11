require 'erb'
require_relative 'view/html_view'
require_relative 'view/plain_view'

module Simpler
  class View

    VIEW_CLASSES = {
      html: HTMLView,
      plain: PlainView
    }

    def initialize(env)
      @env = env
    end

    def render(binding)
      view = select_view_class
      view.new(@env).render(binding)
    end

    private

    def select_view_class
      VIEW_CLASSES[response_type]
    end

    def response_type
      @env['simpler.template_type']
    end

  end
end
