require 'faraday'
require 'json'
require 'pry'
require './app/models/api/holiday_search'

class HolidayService
  def initialize 
  end 
  def make_request(endpoint)
    response = Faraday.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end

  def upcoming_holidays
    make_request("https://date.nager.at/api/v3/NextPublicHolidays/US")
  end
end 
