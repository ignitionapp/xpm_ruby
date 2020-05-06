require_relative "../../types"

module XpmRuby
  module Schema
    module Job
      Applytemplate = Types::Hash.schema(
        ID: Types::Coercible::String,
        TemplateID: Types::Coercible::String,
        TaskMode: Types::String
      ).with_key_transform(&:to_sym)
    end
  end
end