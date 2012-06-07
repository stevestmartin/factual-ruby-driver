require 'factual/query/base'

class Factual
  module Query
    class Monetize < Base
      VALID_PARAMS  = [
        :filters, :search, :geo, 
        :limit, :offset
      ] 

      def initialize(api, params = {})
        @path = "places/monetize"
        @action = :read
        super(api, params)
      end

      VALID_PARAMS.each do |param|
        define_method(param) do |*args|
          self.class.new(@api, @params.merge(param => form_value(args)))
        end
      end
    end
  end
end
