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

    # Return the header selectors for the levels indicated.
    # Defaults to all headers h1 through h6.
    #
    # For example:
    #   headers(all) => h1, h2, h3, h4, h5, h6
    #   headers(4) => h1, h2, h3, h4
    #   headers(2,4) => h2, h3, h4
    #
    # Note: This function is ported from Compass.
    def headers(from = nil, to = nil)
      if from && !to
        if from.is_a?(Value::String) && from.value == 'all'
          from = number(1)
          to = number(6)
        else
          to = from
          from = number(1)
        end
      else
        from ||= number(1)
        to ||= number(6)
      end
      list((from.value..to.value).map { |n| identifier("h#{n}") }, :comma)
    end
  end
end
