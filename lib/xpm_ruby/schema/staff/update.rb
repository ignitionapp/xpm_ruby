require_relative "../../types"

module XpmRuby
  module Schema
    module Staff
      Update = Types::Hash.schema(
        ID: Types::Coercible::String,
        Name: Types::String,
        Address?: Types::String,
        Phone?: Types::String,
        Mobile?: Types::String,
        Email?: Types::String,
        PayrollCode?: Types::String
      ).with_key_transform(&:to_sym)
    end
  end
end
