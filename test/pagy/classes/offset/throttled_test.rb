require_relative '../../../test_helper'
require_relative '../../../../gem/lib/pagy/toolbox/helpers/support/series' # just to check the series

describe 'pagy throttled' do
	let(:pagy) { Pagy::Offset::Throttled.new(count: 100, page: 4) }

	it "initializes" do
		_(pagy).must_be_instance_of Pagy::Offset::Throttled
	end
end