# See Pagy API documentation: https://ddnexus.github.io/pagy/docs/api/keyset
# frozen_string_literal: true

require_relative '../keyset'

class Pagy # :nodoc:
  # Implement wicked-fast, no-frills keyset pagination for big data
  class Keyset
    # Keyset subclass  for Activrecord
    class Activerecord < Keyset
      # Has selected columns?
      def select?
        !@set.select_values.empty?
      end

      # Typecast the hash of the keyset columns values
      def typecast_cursor(cursor)
        @set.model.new(cursor).slice(cursor.keys)
      end

      # Extract the keyset from the set
      def extract_keyset
        @set.order_values.each_with_object({}) do |node, keyset|
          keyset[node.value.name] = node.direction
        end
      end

      def placeholder_for(column) = ":#{column}"
    end
  end
end
