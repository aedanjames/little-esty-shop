require 'rails_helper'
require 'pry'
require './app/models/api/holiday_service'

RSpec.describe HolidayService do 
  it 'exists' do 
    api = HolidayService.new
  end 

  it 'can retrieve upcoming holidays' do 
    api = HolidayService.new 
    expect(api.upcoming_holidays.first).to be_a(Hash)
  end 
end 