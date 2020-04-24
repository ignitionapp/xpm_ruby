module XpmRuby
  module Staff
    class SaxParser < Ox::Sax
      attr_reader :staff_list

      def initialize
        @staff_list = []
        @element_names = []

        super
      end

      def start_element(name)
        # puts "start: #{name}"

        @element_names.push(name)

        case name
        when :Staff
          @staff_list << Model.new
        end
      end

      def end_element(name)
        # puts "end: #{name}"

        @element_names.pop
      end

      def attr(name, value)
        # puts "  #{name} => #{value}"
      end

      def text(value)
        # puts "text #{value}"

        return if value.empty?

        case @element_names.last
        when :UUID
          @staff_list.last.uuid = value
        when :Name
          @staff_list.last.name = value
        when :Email
          @staff_list.last.email = value
        when :Phone
          @staff_list.last.phone = value
        when :Mobile
          @staff_list.last.mobile = value
        when :Address
          @staff_list.last.address = value
        when :PayrollCode
          @staff_list.last.payroll_code = value
        end
      end
    end
  end
end
