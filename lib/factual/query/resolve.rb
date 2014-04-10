class Factual
  module Query
    class Resolve < Base
      def initialize(api, params = {})
        @path = params.delete(:us_only) { false } ? "t/places-us/resolve" : "t/places/resolve"
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
