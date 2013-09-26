class Factual
  module Query
    class Geocode < Base
      def initialize(api, lat, lng)
        @path = "places/geocode"
        @action = :read
        @params = {:geo => {"$point" => [lat, lng]}}

        super(api, @params)
      end
    end
  end
end
