# See Pagy API documentation: https://ddnexus.github.io/pagy/docs/api/keyset
# frozen_string_literal: true

require 'json'
require_relative 'b64'
require_relative 'init_vars'

class Pagy # :nodoc:
  # Implement wicked-fast, no-frills keyset pagination for big data
  class Keyset
    include InitVars

    attr_reader :page, :cursor, :vars

    def initialize(set, page: nil, **vars)
      @set  = set
      @page = page
      normalize_vars(vars)
      setup_items_var
      @keyset = extract_keyset
      raise InternalError, 'the set must be ordered' if @keyset.empty?
      return unless @page

      cursor  = JSON.parse(B64.urlsafe_decode(@page)).transform_keys(&:to_sym)
      @cursor = @vars[:typecast_cursor]&.(cursor) || typecast_cursor(cursor)
      raise InternalError, 'page and keyset are not consistent' \
            unless @cursor.keys == @keyset.keys
    end

    # The next page
    def next
      records
      return unless @more

      @next ||= B64.urlsafe_encode(cursor_from(@records.last).to_json)
    end

    # The array of records for the current page
    def records
      @records ||= begin
        @set    = @set.select(*@keyset.keys.map(&:to_sym)) if select?
        @set    = @vars[:after_where]&.(@set, @cursor) || after_where if @cursor
        records = @set.limit(@items + 1).to_a
        @more   = records.size > @items && !records.pop.nil?
        records
      end
    end

    protected

    # Prepare the after where literal query
    def after_where_query
      operator   = { asc: '>', desc: '<' }
      directions = @keyset.values
      if @vars[:row_comparison] && (directions.all?(:asc) || directions.all?(:desc))
        # Row comparison: works for same directions keysets
        # Use B-tree index for performance
        columns      = @keyset.keys
        placeholders = columns.map { |column| ":#{column}" }.join(', ')
        "( #{columns.join(', ')} ) #{operator[directions.first]} ( #{placeholders} )"
      else
        # Generic comparison: works for keysets ordered in mixed or same directions
        keyset = @keyset.to_a
        where  = []
        until keyset.empty?
          last_column, last_direction = keyset.pop
          query = +'( '
          query << (keyset.map { |column, _d| "#{column} = :#{column}" } \
                    << "#{last_column} #{operator[last_direction]} :#{last_column}").join(' AND ')
          query << ' )'
          where << query
        end
        where.join(' OR ')
      end
    end
  end
end

require_relative 'keyset/activerecord'
require_relative 'keyset/sequel'
