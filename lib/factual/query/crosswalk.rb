require 'factual/query/base'

class Factual
  module Query
    class Crosswalk < Base
      def initialize(api, params = {})
        @path = "t/crosswalk"
        @action = :read
        super(api, params)
      end

      def only(*namespaces)
        filters = @params[:filters] ? @params[:filters].dup : {}

        if (namespaces.length == 1)
          filters.merge!(:namespace => namespaces.first)
        else
          filters.merge!(:namespace => {"$in" => namespaces})
        end

        self.class.new(@api, @params.merge(:filters => filters))
      end

      [:limit, :include_count].each do |param|
        define_method(param) do |*args|
          self.class.new(@api, @params.merge(param => form_value(args)))
        end
      end
    end
  end
end
