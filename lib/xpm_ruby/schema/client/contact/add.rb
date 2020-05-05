require_relative "../../../types"

module XpmRuby
  module Schema
    module Client
      module Contact
        Add = Types::Hash.schema(
          Client: Types::Hash.schema(
            ID: Types::Coercible::String
          ).with_key_transform(&:to_sym),
          Name?: Types::String,
          IsPrimary?: Types::Bool,
          Salutation?: Types::String,
          Addressee?: Types::String,
          Mobile?: Types::String,
          Email?: Types::String,
          Phone?: Types::String,
          Position?: Types::String
        ).with_key_transform(&:to_sym)
      end
    end
  end
end
