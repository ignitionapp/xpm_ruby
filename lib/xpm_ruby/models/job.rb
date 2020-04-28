module XpmRuby
  module Models
    class Job
      # job has more fields on it, but these are the only ones we appear to be using
      attr_accessor :uuid, :name, :description, :state, :start_date, :due_date, :completed_date

      def initialize(uuid: nil, name: nil, description: nil, state: nil, start_date: nil, due_date: nil, completed_date: nil)
        @uuid = uuid
        @name = name
        @description = description
        @state = state
        @start_date = start_date
        @due_date = due_date
        @completed_date = completed_date
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
