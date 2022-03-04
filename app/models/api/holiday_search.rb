require 'pry'
require './app/models/api/holiday_service'
require './app/models/api/holiday'

class HolidaySearch 
  def holiday_information 
    service.upcoming_holidays.each do |data|
      Holiday.new(data)
    end 
  end 

    def service
      HolidayService.new
    end 
end 

# a = HolidaySearch.new
# binding.pry
# a.holiday_information