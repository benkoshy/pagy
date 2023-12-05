# frozen_string_literal: true

require_relative '../../test_helper'
require 'pagy/extras/json_api'

require_relative '../../mock_helpers/collection'
require_relative '../../mock_helpers/app'

	# Notes
    
    # json_api likes to nest the params
    # http://example.com/articles?&page=4
    # params # => {"page"=>{"number"=>"4", "size" => 123} }

    # Possible use-case implementation
    # pagy, records = pagy(Product.all)
    # render json: { data: records, links: pagy_json_api(pagy, ...).as_json }

    # Perhaps we should just return a hash 
    # users serialise to JSON however they want.



    # pagy_get_vars - must handle nested params
    # pagy_json_api -> pagy_url_for --> must handle nested params
    #                               --> must handle 'last' and also 'last_url' (naming clash)
    # I am not sure whether we should sub-class. 
    # We might be able to just have a fresh method without renaming


describe 'pagy/extras/metadata' do
  describe '#pagy_json_api for Pagy' do
  	let(:app) { MockApp.new }
    before do
      @collection = MockCollection.new
    end    

    it 'returns the links hash' do      
      pagy, records = pagy(@collection)
      assert_equal Pagy::JsonAPI.pagy_json_api(pagy), links
    end    

    
    # backend method
    def pagy(collection, vars = {})    	
      pagy = Pagy.new(pagy_get_vars(collection, vars))
      [pagy, @collection]      
    end

    private

    # backend method
    # because the pagination params are nested we'd have to extract them
    def pagy_get_vars(collection, vars)
      vars[:count] ||= (count = collection.count(:all)).is_a?(Hash) ? count.size : count
      vars[:page]  ||= params[:page][:number] || DEFAULT[:page][:page_param]   
      vars
    end


    def params
       	ActiveSupport::HashWithIndifferentAccess.new().merge({:page=>{:number=>"4", :size => 123}})    	
    end

    def links
     	{ 	"self": "http://example.com/articles?page[number]=3&page[size]=1", 
     	  	"first": "http://example.com/articles?page[number]=1&page[size]=1",
	        "prev": "http://example.com/articles?page[number]=2&page[size]=1",
	        "next": "http://example.com/articles?page[number]=4&page[size]=1",
	        "last": "http://example.com/articles?page[number]=13&page[size]=1"
    	}
    end
    

  end
end

