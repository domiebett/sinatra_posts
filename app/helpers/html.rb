require 'sinatra/base'

module Html
  module JavascriptHelpers
    def javascripts(*args)
      js = []
      js << args

      js.flatten.uniq.map do |script|
        %(<script type="text/javascript"
                  src="javascript/#{script}.js">
        </script>)
      end.join
    end
  end

  module StyleHelpers
    def styles(*args)
      styles = []
      styles << args

      styles.flatten.uniq.map do |style|
        %(<link rel="stylesheet" type="text/css" href="css/#{style}.css">)
      end.join
    end
  end

  module FormHelpers
    HTML_METHODS = %w[PUT PATCH DELETE].freeze

    def use_method(method = 'PUT')
      method = HTML_METHODS.include?(method.to_s.upcase) ? method : 'GET'
      %(<input type="hidden" name="_method" value="#{method}"/>)
    end

    def text_input(name, value = '')
      name = name.to_s
      %(
      <div class="text_input_holder" id="#{name}_text_input_holder">
        <label for="#{name}_text_input">#{name}</label>
        <input type="text"
                id="#{name}_text_input"
                name="#{name}"
                placeholder="Enter #{name}"
                value="#{value}" />
      </div>
      )
    end

    def text_area(name, value = '')
      name = name.to_s
      %(
      <div class="text_area_holder" id="#{name}_text_area_holder">
        <label for="#{name}_text_input">#{name}</label>
        <textarea id="#{name}_text_input"
                  placeholder="Enter #{name}"
                  name="#{name}">#{value}
        </textarea>
      </div>
      )
    end

    def submit_button(submit_button_value)
      submit_button = %(
        <input class="button
                submit_button"
                type="submit"
                value="#{submit_button_value}"/>
      )

      %(
      <div class="submit_button_holder">
        #{submit_button}
      </div>
      )
    end

    def button_to(value, method, route)
      %(
        <form method="POST" action="#{route}">
          #{use_method(method)}
          #{submit_button(value)}
        </form>
      )
    end
  end
end
