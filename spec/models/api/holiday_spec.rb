require 'rails_helper'
require 'pry'
require './app/models/api/holiday'

RSpec.describe Holiday, type: :model do 
  it 'exists' do 
    data = {:date=>"2022-04-15",
    :localName=>"Good Friday",
    :name=>"Good Friday",
    :countryCode=>"US",
    :fixed=>false,
    :global=>false,
    :counties=>["US-CT", "US-DE", "US-HI", "US-IN", "US-KY", "US-LA", "US-NC", "US-ND", "US-NJ", "US-TN"],
    :launchYear=>nil,
    :types=>["Public"]}
    expect(holiday = Holiday.new(data)).to be_a(Holiday)
  end 

  it 'has attributes' do 
    data = {:date=>"2022-04-15",
    :localName=>"Good Friday",
    :name=>"Good Friday",
    :countryCode=>"US",
    :fixed=>false,
    :global=>false,
    :counties=>["US-CT", "US-DE", "US-HI", "US-IN", "US-KY", "US-LA", "US-NC", "US-ND", "US-NJ", "US-TN"],
    :launchYear=>nil,
    :types=>["Public"]}
    holiday = Holiday.new(data)
    expect(holiday.date).to eq("2022-04-15")
    expect(holiday.name).to eq("Good Friday")
    expect(holiday.local_name).to eq("Good Friday")
    expect(holiday.country_code).to eq("US")
  end 
end 