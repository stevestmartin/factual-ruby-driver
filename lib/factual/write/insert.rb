require 'factual/write/base'

class Factual
  module Write
    class Insert < Base
      VALID_KEYS = [
        :table, :user,
        :values,
        :comment, :reference
      ]

      def initialize(api, params)
        validate_params(params)
        super(api, params)
      end

      VALID_KEYS.each do |key|
        define_method(key) do |*args|
          Insert.new(@api, @params.merge(key => form_value(args)))
        end
      end

      def path
        "/t/#{@params[:table]}/insert"
      end

      private

      def validate_params(params)
        params.keys.each do |key|
          raise "Invalid insert option: #{key}" unless VALID_KEYS.include?(key)
        end
      end
    end
  end
end
