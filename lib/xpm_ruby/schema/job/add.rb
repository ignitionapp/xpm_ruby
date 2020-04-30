require_relative "../../types"

module XpmRuby
  module Schema
    module Job
      Add = Types::Hash.schema(
        Name: Types::String,
        Description: Types::String,
        ClientID: Types::Coercible::String,
        ContactID?: Types::Coercible::String,
        StartDate: Types::Coercible::String,
        DueDate: Types::Coercible::String,
        ClientNumber?: Types::Coercible::String,
        ID?: Types::Coercible::String,
        TemplateID?: Types::Coercible::String,
        CategoryID?: Types::Coercible::String,
        Budget?: Types::Coercible::String
      )
    end
  end
end
