require_relative "../../types"

module XpmRuby
  module Schema
    module Job
      Delete = Types::Hash.schema(
        ID: Types::Coercible::String
      ).with_key_transform(&:to_sym)
    end
  end
end
