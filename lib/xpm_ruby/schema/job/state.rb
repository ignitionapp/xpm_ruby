require_relative "../../types"

module XpmRuby
  module Schema
    module Job
      State = Types::Hash.schema(
        ID: Types::Coercible::String,
        State: Types::String
      ).with_key_transform(&:to_sym)
    end
  end
end
