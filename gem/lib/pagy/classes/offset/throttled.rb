# frozen_string_literal: true

class Pagy
  class Offset
    # Offset pagination with a leased count
    class Throttled < Offset
      protected

      def compose_page_param(page) = "#{page || 1}+#{@count}+#{@options[:timestamp]}"
    end
  end
end
