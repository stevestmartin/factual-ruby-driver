require 'rubygems'
gem 'oauth'

require 'oauth'
require 'factual/api'
require 'factual/query/table'
require 'factual/query/facets'
require 'factual/query/match'
require 'factual/query/resolve'
require 'factual/query/monetize'
require 'factual/query/geocode'
require 'factual/query/geopulse'
require 'factual/write/flag'
require 'factual/write/submit'
require 'factual/write/clear'
require 'factual/write/insert'
require 'factual/multi'

class Factual
  def initialize(key, secret, options = {})
    debug_mode = options[:debug].nil? ? false : options[:debug]
    host = options[:host]
    timeout = options[:timeout]
    @api = API.new(generate_token(key, secret), debug_mode, host, timeout)
  end

  def table(table_id_or_alias)
    Query::Table.new(@api, "t/#{table_id_or_alias}")
  end

  def facets(table_id_or_alias)
    Query::Facets.new(@api, "t/#{table_id_or_alias}")
  end

  def monetize
    Query::Monetize.new(@api)
  end

  def match(values)
    Query::Match.new(@api, :values => values)
  end

  def resolve(values)
    Query::Resolve.new(@api, :values => values)
  end

  def geocode(lat, lng)
    Query::Geocode.new(@api, lat, lng)
  end

  def geopulse(lat, lng)
    Query::Geopulse.new(@api, lat, lng)
  end

  def get(path, query={})
    @api.raw_get(path, query)
  end

  def post(path, body={})
    @api.raw_post(path, body)
  end

  def diffs(view, params = {})
    @api.diffs(view, params)
  end

  def multi(queries)
    multi = Multi.new(@api, queries)
    multi.send
  end

  def clear(table, user, factual_id, fields)
    clear_params = {
      :table => table,
      :factual_id => factual_id,
      :fields => fields.to_a.join(","),
      :user => user }

    Write::Clear.new(@api, clear_params)
  end

  def flag(table, user, factual_id, problem)
    flag_params = {
      :table => table,
      :factual_id => factual_id,
      :problem => problem,
      :user => user }

    Write::Flag.new(@api, flag_params)
  end

  def submit(*params)
    values = {}
    values = params.pop if params.last.is_a? Hash

    table, user, factual_id = params
    submit_params = {
      :table => table,
      :user => user,
      :factual_id => factual_id,
      :values => values }
    Write::Submit.new(@api, submit_params)
  end

  def insert(*params)
    values = {}
    values = params.pop if params.last.is_a? Hash

    table, user = params
    insert_params = {
      :table => table,
      :user => user,
      :values => values }
    Write::Insert.new(@api, insert_params)
  end

  private

  def generate_token(key, secret)
    OAuth::AccessToken.new(OAuth::Consumer.new(key, secret))
  end
end
