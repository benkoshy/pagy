---
label: "&nbsp;✳&nbsp;&nbsp;&nbsp;Helpers"
icon: mention
order: 80
---

#

## ✳&nbsp;&nbsp;Helpers

---

The `@pagy` instance provides all the helpers to use in your code.

Its class is determined by the paginator used, but you can safely ignore it.

!!!success The `@pagy` helpers are autoloaded only if used!
Unused code consumes no memory.
!!!

==- :icon-sliders:&nbsp; Shared Options

!!! Helpers may add and document specific [Options](configuration/options).
!!!

:icon-crosshairs-24:&nbsp; URL Options
: See [URL Options](/resources/urls#options)

`anchor_string: 'data-turbo-frame="paginate"'`
: Concatenate a verbatim raw string to the internal HTML of the anchor tags. It must contain properly formatted HTML attributes. It's not suitable for `*_hash` helpers.

==- :icon-sliders:&nbsp; Navs Shared Options

`id: 'my-nav'`
: Set the `id` HTML attribute of the `nav` tag.

`aria_label: 'My Label'`
: Override the default `pagy.aria_label.nav` string of the `aria-label` attribute.<br/>See [ARIA](/resources/aria.md)

  !!!danger The `nav` elements are `landmark  roles`, and should be distinctly labeled!

  !!!success Override the default `:aria_label`s for multiple navs with distinct values!

  ```erb
  <%# Explicitly set the aria_label %>
  <%== @pagy.series_nav(aria_label: 'Search result pages') %>
  ```
==- :icon-eye:&nbsp; Shared Nav Styles

`:pagy/nil`
: Pagy default style

`:bootstrap`
: Set `classes: 'pagination pagination-sm any-class'` style option to override the default `'pagination'` class.

`:bulma`
: Set `classes: 'pagination is-small any-class'` style option to override the default `'pagination'` classes.

===
