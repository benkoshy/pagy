# frozen_string_literal: true


# See the Pagy documentation: https://ddnexus.github.io/pagy/docs/extras/json_api # remember to add a page here

require 'pagy/url_helpers'

class Pagy # :nodoc:

  DEFAULT[:metadata] = %i[ scaffold_url first_url prev_url page_url next_url last
                           count page items vars pages last in from to prev next series ]
  # there is a conflict between last, and the last_usl


  
  module JsonAPI
    private

    include UrlHelpers
    
    def pagy_json_api(pagy, absolute: nil)
      
      scaffold_url = pagy_url_for(pagy, PAGE_PLACEHOLDER, absolute: absolute)  # pagy_url_for must handle nested params
      {}.tap do |json_api|
        keys = defined?(Calendar) && pagy.is_a?(Calendar) ? pagy.vars[:json_api] - %i[count items] : pagy.vars[:json_api]
        keys.each do |key|
          json_api[key] = case key
                          when :scaffold_url then scaffold_url
                          when :first    then scaffold_url.sub(PAGE_PLACEHOLDER, 1.to_s)
                          when :prev     then scaffold_url.sub(PAGE_PLACEHOLDER, pagy.prev.to_s)
                          when :page_url     then scaffold_url.sub(PAGE_PLACEHOLDER, pagy.page.to_s)
                          when :next     then scaffold_url.sub(PAGE_PLACEHOLDER, pagy.next.to_s)
                          when :last     then scaffold_url.sub(PAGE_PLACEHOLDER, pagy.last.to_s)
                          else pagy.send(key)
                          end
        rescue NoMethodError
          raise VariableError.new(pagy, :json_api, 'to contain known keys', key)
        end
      end
    end
  end
  Backend.prepend JsonAPI
end
