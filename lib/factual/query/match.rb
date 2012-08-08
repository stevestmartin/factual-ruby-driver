require 'factual/query/base'

class Factual
  module Query
    class Match < Base
      def initialize(api, params = {})
        @path = "places/match"
        @action = :read
        super(api, params)
      end

      [:values].each do |param|
        define_method(param) do |*args|
          self.class.new(@api, @params.merge(param => form_value(args)))
        end
      end
    end
  end
end
