require_relative '../../../test_helper'
require_relative '../../../mock_helpers/collection'
require_relative '../../../mock_helpers/app'

require "active_support/testing/time_helpers" 

include ActiveSupport::Testing::TimeHelpers

# focus on update_lease
# yes... and especially the update_lease method
# to check the different combinations of conditions
#  that persist or refresh... besides the presence/absence of count_ttl and its implications (also
# fot the page param value in the query string)

describe 'Throttle' do
  let(:app) { MockApp.new }

  describe ":throttled" do
    before do
      @collection = MockCollection.new
    end

    it "paginate with page string" do          
      app = MockApp.new(params: { page: '1 2 3' })
      pagy, records = app.send(:pagy, :throttled, @collection)

      _(pagy).must_be_instance_of Pagy::Offset::Throttled
      _(pagy.page).must_equal 1
      _(pagy.count).must_equal 2
      _(pagy.limit).must_equal 20
    end

    it "paginate with nil count_ttl" do                
      app = MockApp.new(params: { page: '1 2 3' })
      pagy, records = app.send(:pagy, :throttled, @collection, count_ttl: nil)

      _(pagy).must_be_instance_of Pagy::Offset::Throttled
      _(pagy.page).must_equal 1
      _(pagy.count).must_equal 2
      _(pagy.limit).must_equal 20
    end

    it "raises TypeError with invalid count_ttl" do          
      skip "invalid"
      app = MockApp.new(params: { page: '1 2 3' })
      _(app.send(:pagy, :throttled, @collection, count_ttl: "error")).must_raise TypeError      
    end

    # time_ok is false
    it "time is greater than now" do            
      now = 0
      time = 1     

      travel_to Time.at(now)      

      app = MockApp.new(params: { page: "1 2 #{time}"})      
      pagy, records = app.send(:pagy, :throttled, @collection, count_ttl: 1)         
      
      _(pagy.page).must_equal 1
      _(pagy.count).must_equal 1000      
    end

	# time_ok is false
    it "now is greater than time, use uncached value" do               
      now = 1
      time = 0     

      travel_to Time.at(now)      

      app = MockApp.new(params: { page: "1 2 #{time}"})      
      pagy, records = app.send(:pagy, :throttled, @collection, count_ttl: 1)         
      
      _(pagy.page).must_equal 1
      _(pagy.count).must_equal 1000      
    end


    # time_ok is true
    it "now is greater than time, use cached count value" do         
      now = 1
      time = 0     

      travel_to Time.at(now)      

      app = MockApp.new(params: { page: "1 2 #{time}"})      
      pagy, records = app.send(:pagy, :throttled, @collection, count_ttl: 2)         
      
      _(pagy.page).must_equal 1
      _(pagy.count).must_equal 2      
    end

    # count options: 500
    it "time is greater than now with count options of 500" do                   
      now = 0
      time = 1     

      travel_to Time.at(now)      

      app = MockApp.new(params: { page: "1 2 #{time}"})      
      pagy, records = app.send(:pagy, :throttled, @collection, count_ttl: 1, count: 500)         
      
      _(pagy.page).must_equal 1
      _(pagy.count).must_equal 500
    end

    # count options nil
     it "time is greater than now with count options of nil" do    
      skip "something wrong with this test"             
      now = 0
      time = 1     

      travel_to Time.at(now)      

      app = MockApp.new(params: { page: "1 2 #{time}"})      
      pagy, records = app.send(:pagy, :throttled, @collection, count_ttl: 1, count: nil)         
      
      _(pagy.page).must_equal 1
      _(pagy.count).must_equal 500
    end


    it "paginate with count_ttl options - unexpired - use cache " do            
      now = 2
      time = 1      

      travel_to Time.at(now)      

      app = MockApp.new(params: { page: "1 2 #{time}"})      
      pagy, records = app.send(:pagy, :throttled, @collection, count_ttl: 2)   
      _(pagy.count).must_equal 2
    end

    it "invalid page value" do 
    	skip
    end

    it "invalid time value" do 
    	skip
    end

    it "invalid count value" do 
    	skip
    end
  end
end
