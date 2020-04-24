module XpmRuby
  module Staff
    class Model
      attr_accessor :uuid, :name, :email, :phone, :mobile, :address, :payroll_code

      def initialize(uuid: nil, name: nil, email: nil, phone: nil, mobile: nil,
                    address: nil, payroll_code: nil)
        @uuid = uuid
        @name = name
        @email = email
        @phone = phone
        @mobile = mobile
        @address = address
        @payroll_code
      end

      def ==(other)
        uuid == other.uuid
      end

      def eql?(other)
        self == other
      end
    end
  end
end
