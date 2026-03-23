`absolute: true`
: Makes the URL absolute.

`fragment: '...'`
: URL fragment string.

`jsonapi: true`
: Enables JSON:API-compliant URLs with nested query string (e.g., `?page[number]=2&page[size]=100`).

`limit_key: 'my_limit'`
: Set it to change the key string used for the `:limit` in URLs (default `'limit'`).

`page_key: 'my_page'`
: Set it to change the key string used for the `:page` in URLs (default `'page'`).

`root_key: 'my_root'`
: Set it to enable nested URLs with nested query string `?my_root[page]=2&my_root[limit]=100`)). Use it to handle multiple pagination objects in the same request.

`path: '/my_path'`
: Overrides the request path in pagination URLs. Use the path only (not the absolute URL). _(see [Override the request path](/guides/how-to#paginate-multiple-independent-collections))_

`querify: tweak`
: Set it to a `Lambda` to directly edit the passed string-keyed params hash itself. Its result is ignored.
```ruby
tweak = ->(q) { q.except!('not_useful').merge!('custom' => 'useful') }
```