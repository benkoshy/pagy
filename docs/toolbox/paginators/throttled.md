---
label: :throttled
icon: list-ordered
order: 95
categories:
  - Paginators
---

#

## :icon-list-ordered: :throttled

---

`:throttled` is an OFFSET paginator that caches the result of the `COUNT` query, querying the count only once per collection or refreshing it periodically. It supports the full UI without limitations.


```ruby Controller 
@pagy, @records = pagy(:throttled, collection, count_ttl: 300, **options)
```

- `@pagy` is the pagination instance. It provides the [readers](#readers) and the [helpers](../helpers) to use in your code.
- `@records` represents the eager-loaded `Array` of records for the page.
- `:count_ttl` is the __Time To Live__ (in seconds) of the cached count.

==- Options

- `:count_ttl` (__Time To Live__ in seconds)
  - Let it `nil` (falsey) to query the DB for the COUNT only once, and reuse it for all the other pages served.
  - Set it to an integer of seconds to refresh the count past the TTL.

See also [Offset Options](offset#options)

==- Readers

See [Offset Readers](offset#readers)

===
