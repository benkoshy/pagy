# See Pagy API documentation: https://ddnexus.github.io/pagy/docs/api/keyset
# frozen_string_literal: true

class Pagy # :nodoc:
  class Keyset
    # Keyset subclass for sequel
    class Sequel < Keyset
      protected

      # Get the hash of key/values of the record
      def cursor_from(record) = record.to_hash.slice(*@keyset.keys)

      # Extract the keyset from the set
      def extract_keyset
        @set.opts[:order].each_with_object({}) do |item, keyset|
          case item
          when Symbol
            keyset[item] = :asc
          when ::Sequel::SQL::OrderedExpression
            keyset[item.expression] = item.instance_values['descending'] ? :desc : :asc
          else
            raise TypeError, "#{item.class} is not a supported Sequel::SQL::OrderedExpression"
          end
        end
      end

      # Add where clause to start from the right record
      def after_where = @set.where(::Sequel.lit(after_where_query, **@cursor))

      # Has selected columns?
      def select? = !@set.opts[:select].nil?

      # Typecast the hash of the keyset columns values
      def typecast_cursor(cursor)
        model = @set.opts[:model]
        model.unrestrict_primary_key
        cursor = model.new(cursor).to_hash.slice(*cursor.keys.map(&:to_sym))
        model.restrict_primary_key
        cursor
      end
    end
  end
end
