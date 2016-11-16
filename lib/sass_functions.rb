require 'sass/script'

module Sass::Script
  module Functions

    def string_to_color(name)
      color = Color::COLOR_NAMES[name.value]
      if color
        Color.new(color)
      else
        fail "Unknown color name: #{name.value}"
      end
    end
  end
end
