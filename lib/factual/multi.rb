class Factual
  class Multi
    attr_reader :action, :path

    def initialize(api, queries)
      @api = api
      @queries = queries

      @action = nil
      @path = '/multi'

      @responses = {}
    end

    def send
      res = @api.post(self)
      @queries.each do |name, query|
        query.populate(res[name.to_s])
        @responses[name] = query
      end

      @responses
    end

    def body
      query_urls = {}
      @queries.each do |name, query|
        query_urls[name] = query.full_path
      end

      "queries=#{ CGI.escape(query_urls.to_json) }"
    end

  end
end
