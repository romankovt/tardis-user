# frozen_string_literal: true

# don't wrap parameters by default

ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: []
end
