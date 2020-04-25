require "dry-types"
require "dry-struct"

module XpmRuby
  module Types
    include Dry.Types

    class Staff < Dry::Struct
      attribute :uuid, Types::Strict::String
      attribute :name, Types::Strict::String
      attribute :email, Types::Strict::String
      attribute :phone, Types::Strict::String.optional.default(nil)
      attribute :mobile, Types::Strict::String.optional.default(nil)
      attribute :address, Types::Strict::String.optional.default(nil)
      attribute :payroll_code, Types::Strict::String.optional.default(nil)
    end
  end
end
