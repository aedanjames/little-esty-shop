require 'rails_helper'
require 'pry'
require './app/models/api/holiday_search'

RSpec.describe HolidaySearch do 
  it 'exists' do 
    search = HolidaySearch.new
    expect(search).to be_a(HolidaySearch)
  end 

  it 'converts parsed JSON objects into ruby model objects' do
    search = HolidaySearch.new 
    expect(search.holiday_information.count).to eq(12)
    expect(search.holiday_information.first.keys).to eq([:date, :localName, :name, :countryCode, :fixed, :global, :counties, :launchYear, :types])
  end 
end 