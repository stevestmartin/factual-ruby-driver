class Factual
  module Write
    class Boost < Base
      VALID_KEYS = [:table, :factual_id, :user, :q]

      def initialize(api, params)
        validate_params(params)
        super(api, params)
        @params_on_path = [:table]
      end

      VALID_KEYS.each do |key|
        define_method(key) do |*args|
          Boost.new(@api, @params.merge(key => form_value(args)))
        end
      end

      def path
        "/t/#{@params[:table]}/boost"
      end

      private

      def validate_params(params)
        params.keys.each do |key|
          raise "Invalid boost option: #{key}" unless VALID_KEYS.include?(key)
        end
      end
    end
  end
end
