require_relative "../../types"

module XpmRuby
  module Schema
    module Job
      Update = Types::Hash.schema(
        ID: Types::Coercible::String,
        Name: Types::String,
        Description: Types::String,
        ContactID?: Types::Coercible::String,
        StartDate: Types::Coercible::String,
        DueDate: Types::Coercible::String,
        ClientNumber?: Types::Coercible::String,
        ID?: Types::Coercible::String,
        TemplateID?: Types::Coercible::String,
        CategoryID?: Types::Coercible::String,
        Budget?: Types::Coercible::String
      ).with_key_transform(&:to_sym)
    end
  end
end
