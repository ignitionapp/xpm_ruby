module XpmRuby
  module Models
    class Template
      attr_accessor :uuid, :name

      def initialize(uuid: nil, name: nil)
        @uuid = uuid
        @name = name
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
