# frozen_string_literal: true

class V1::UserSerializer < V1::BaseSerializer
  attributes :phone, :email, :first_name, :last_name
end
