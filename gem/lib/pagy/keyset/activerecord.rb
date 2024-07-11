# See Pagy API documentation: https://ddnexus.github.io/pagy/docs/api/keyset
# frozen_string_literal: true

class Pagy # :nodoc:
  class Keyset
    # Keyset subclass  for Activrecord
    class ActiveRecord < Keyset
      protected

      # Get the hash of key/values of the record
      def cursor_from(record) = record.slice(*@keyset.keys)

      # Extract the keyset from the set
      def extract_keyset
        @set.order_values.each_with_object({}) do |node, keyset|
          keyset[node.value.name.to_sym] = node.direction
        end
      end

      # Add where clause to start from the right record
      def after_where = @set.where(after_where_query, @cursor)

      # Has selected columns?
      def select? = !@set.select_values.empty?

      # Typecast the hash of the keyset columns values
      def typecast_cursor(cursor)
        @set.model.new(cursor).slice(cursor.keys)
            .to_hash.transform_keys(&:to_sym)
      end
    end
  end
end
