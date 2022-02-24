require 'rack'
require_relative 'clock'

class App
  def call(env)
    @env = env
    @format = Rack::Utils.parse_query(env['QUERY_STRING'])['format']
    responce
  end

  private

  def responce
    return [405, {}, ["Wrong request method\n"]] unless @env['REQUEST_METHOD'] == 'GET'
    return [400, {}, ["Format parameter can't be nill\n"]] if @format.nil?

    clock = Clock.new(@format)
    return [400, {}, ["Unknown time format #{clock.unknown_format}\n"]] unless clock.valid?

    [200, {}, ["#{clock.time}\n"]]
  end
end
