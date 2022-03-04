require 'rails_helper'
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

  it 'can return info about three upcoming holidays' do 
    search = HolidaySearch.new
    expect(search.next_three_holidays.count).to eq(3)
    expect(search.next_three_holidays).to eq([{:date=>"2022-04-15",
                                                :localName=>"Good Friday",
                                                :name=>"Good Friday",
                                                :countryCode=>"US",
                                                :fixed=>false,
                                                :global=>false,
                                                :counties=>["US-CT", "US-DE", "US-HI", "US-IN", "US-KY", "US-LA", "US-NC", "US-ND", "US-NJ", "US-TN"],
                                                :launchYear=>nil,
                                                :types=>["Public"]},
                                              {:date=>"2022-05-30", 
                                                :localName=>"Memorial Day",  
                                                :name=>"Memorial Day", 
                                                :countryCode=>"US", 
                                                :fixed=>false, 
                                                :global=>true, 
                                                :counties=>nil, 
                                                :launchYear=>nil, 
                                                :types=>["Public"]},
                                              {:date=>"2022-06-20", 
                                                :localName=>"Juneteenth", 
                                                :name=>"Juneteenth", 
                                                :countryCode=>"US", 
                                                :fixed=>false, 
                                                :global=>true, 
                                                :counties=>nil, 
                                                :launchYear=>2021, 
                                                :types=>["Public"]}])
  end 
end 