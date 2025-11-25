require_relative '../../../test_helper'
require_relative '../../../mock_helpers/collection'
require_relative '../../../mock_helpers/app'

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
    	end

    	it "paginate with empty page" do 
    		skip    		
    	end

    	it "paginate with empty page and a request object" do 
    		skip    		
    	end
	end
end