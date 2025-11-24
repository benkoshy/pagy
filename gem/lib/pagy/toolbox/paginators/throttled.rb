# frozen_string_literal: true

require_relative '../../modules/abilities/countable'

class Pagy
  module ThrottledPaginator
    module_function

    # Return the Offset::Throttled instance and records
    def paginate(collection, options)
      options[:page] ||= options[:request].resolve_page(force_integer: false)
      if options[:page].is_a?(String)
        page, count, time = options[:page].split(/ /, 3).map(&:to_i)
        options[:page]    = page
      end
      update_lease(count, time, collection, options)
      options[:limit] = options[:request].resolve_limit
      pagy            = Offset::Throttled.new(**options)
      [pagy, pagy.records(collection)]
    end

    def update_lease(count, time, collection, options)
      now     = Time.now.to_i
      time_ok = !options[:count_ttl] || (time && time <= now && now < (time + options[:count_ttl]))
      if !options[:count] && count && time_ok  # persist
        options[:count]     = count
        options[:timestamp] = time if options[:count_ttl]
      else                                           # refresh
        options[:count]   ||= Countable.get_count(collection, options)
        options[:timestamp] = now if options[:count_ttl]
      end
    end
  end
end
