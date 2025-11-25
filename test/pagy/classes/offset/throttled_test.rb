require_relative '../../../test_helper'
require_relative '../../../../gem/lib/pagy/toolbox/helpers/support/series' # just to check the series

describe 'pagy throttled' do
	let(:pagy) { Pagy::Offset::Throttled.new(count: 100, page: 4) }

	it "initializes" do
		_(pagy).must_be_instance_of Pagy::Offset::Throttled
	end

	it "initializes pages" do 
		 Pagy::Offset::Throttled.new(count: 100, page: 1)
		_(pagy.send(:compose_page_param, 1)).must_equal "1+100+"
	end

	

end