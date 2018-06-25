module Helpers
  module ParamHelpers
    def permit_params(params, *args)
      permitted_params = []
      permitted_params << args

      params.select { |key, value| permitted_params.include? key }
    end
  end

  module AuthHelpers
    require_relative('../models/user')

    def current_user(user_id)
      current_user = User.find(user_id) unless user_id.nil?
    end
  end
end