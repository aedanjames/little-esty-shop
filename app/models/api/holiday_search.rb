require './app/models/api/holiday_service'
require './app/models/api/holiday'

class HolidaySearch 

  def holiday_information 
    service.upcoming_holidays.each do |data|
      Holiday.new(data)
    end 
  end 

  def next_three_holidays
    holiday_information[0..2]
  end 

    def service
      HolidayService.new
    end 
end 