---
label: :countless
icon: move-to-end-24
order: 90
---

#

## :icon-move-to-end-24:&nbsp;&nbsp;:countless

---

`:countless` is an [OFFSET](/guides/choose-right/#offset) paginator that avoids the `COUNT` query, reducing the number of queries per page in half. UI helpers are working with some limitations (see [Caveat](#caveat)).

!!!warning Consider using the `:keynav_js` paginator when possible!
The [:keynav_js](keynav_js.md) offers identical UI features but utilizes the faster [KEYSET](/guides/choose-right) pagination.
!!!

=== :icon-tools:&nbsp; Usage

```ruby Controller
@pagy, @records = pagy(:countless, collection, **options)
```

- `@pagy` is the pagination instance. It provides the [readers](#readers) and the [helpers](../helpers) to use in your code.
- `@records` represents the eager-loaded `Array` of records for the page.

==- :icon-sliders:&nbsp; Options

`headless: true`
: Use this option when UI is unnecessary (e.g., for infinite scrolling) and/or to skip eager loading. In this scenario:
  - `@pagy` is incompatible with any helpers.
  - `@records` behaves like a standard collection.
  - The collection ends when `@records.size < @pagy.limit`.

{{ include "snippets/offset-options" }}

==- :icon-mention:&nbsp; Readers

{{ include "snippets/offset-readers" }}

==- :icon-alert:&nbsp; Caveat

Nav bar links beyond the highest visited page are not displayed.

===
