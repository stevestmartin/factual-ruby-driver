class Factual
  class Multi
    attr_reader :action, :path, :params

    def initialize(api, queries)
      @api = api
      @queries = queries

      @action = nil
      @path = :multi
      @params = queries_param

      @responses = {}
    end

    def send
      res = @api.get(self)
      @queries.each do |name, query|
        query.populate(res[name])
        @responses[name] = query
      end

      @responses
    end

    private

    def queries_param
      query_urls = {}
      @queries.each do |name, query|
        query_urls[name] = query.full_path
      end

      { :queries => query_urls }
    end

  end
end
