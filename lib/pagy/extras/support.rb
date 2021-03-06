# See the Pagy documentation: https://ddnexus.github.io/pagy/extras/support
# frozen_string_literal: true

class Pagy

  module Frontend

    def pagy_prev_url(pagy)
      pagy_url_for(pagy.prev, pagy) if pagy.prev
    end

    def pagy_next_url(pagy)
      pagy_url_for(pagy.next, pagy) if pagy.next
    end

    def pagy_prev_link(pagy, text = pagy_t('pagy.nav.prev'), link_extra = '')
      if pagy.prev
        %(<span class="page prev"><a href="#{pagy_url_for(pagy.prev, pagy)}" rel="prev" aria-label="previous" #{pagy.vars[:link_extra]} #{link_extra}>#{text}</a></span>)
      else
        %(<span class="page prev disabled">#{text}</span>)
      end
    end

    def pagy_next_link(pagy, text = pagy_t('pagy.nav.next'), link_extra = '')
      if pagy.next
        %(<span class="page next"><a href="#{pagy_url_for(pagy.next, pagy)}" rel="next" aria-label="next" #{pagy.vars[:link_extra]} #{link_extra}>#{text}</a></span>)
      else
        %(<span class="page next disabled">#{text}</span>)
      end
    end

    def pagy_prev_link_tag(pagy)
      %(<link href="#{pagy_url_for(pagy.prev, pagy)}" rel="prev"/>) if pagy.prev
    end

    def pagy_next_link_tag(pagy)
      %(<link href="#{pagy_url_for(pagy.next, pagy)}" rel="next"/>) if pagy.next
    end

  end

end
