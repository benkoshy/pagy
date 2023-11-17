require_relative '../../test_helper'


class Pagy
  module JsonAPI
    # similar to metadata extra
    # but provide the default return values so that it complies with json api specs.

    # we may also need to change the default params that pagy uses.
    # e.g. instead of having as per standard default.
    # http://example.com/articles?&page=4
    # params # => {"page"=>{"number"=>"4", "size" => 123} }

    # pagy, records = pagy(Product.all)
    # render json: { data: records, links: pagy_json_api(pagy, ...) }

    def pagy_json_api
    end

    def links
    end

    # Generic specs: https://jsonapi.org/format/#fetching-pagination
    # We must return the following object
=begin
    "links": {
      "self": "http://example.com/articles?page[number]=3&page[size]=1",
      "first": "http://example.com/articles?page[number]=1&page[size]=1",
      "prev": "http://example.com/articles?page[number]=2&page[size]=1",
      "next": "http://example.com/articles?page[number]=4&page[size]=1",
      "last": "http://example.com/articles?page[number]=13&page[size]=1"
    }
=end
  end
end