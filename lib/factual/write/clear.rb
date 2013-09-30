class Factual
  module Write
    class Clear < Base
      VALID_KEYS = [
        :table, :user,
        :factual_id, :fields,
        :clear_blanks,
        :comment, :reference
      ]

      def initialize(api, params)
        validate_params(params)
        super(api, params)
      end

      VALID_KEYS.each do |key|
        define_method(key) do |*args|
          Clear.new(@api, @params.merge(key => form_value(args)))
        end
      end

      def path
        "/t/#{@params[:table]}/#{@params[:factual_id]}/clear"
      end

      private

      def validate_params(params)
        params.keys.each do |key|
          raise "Invalid submit option: #{key}" unless VALID_KEYS.include?(key)
        end
      end
    end
  end
end
