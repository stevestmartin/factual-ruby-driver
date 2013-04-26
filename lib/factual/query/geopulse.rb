require 'factual/query/base'

class Factual
  module Query
    class Geopulse < Base
      def initialize(api, lat, lng, params={})
        @path = "geopulse/context"
        @action = :read
        @lat = lat
        @lng = lng

        @params = {:geo => {"$point" => [lat, lng]}}.merge(params)
        super(api, @params)
      end

      def select(*args)
        self.class.new(@api, @lat, @lng, :select => form_value(args))
      end
    end
  end
end
