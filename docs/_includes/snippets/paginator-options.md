`limit: 10`
: Specifies the number of items per page (default: `20`)

`max_pages: 500`
: Restricts pagination to only `:max_pages`. _(Ignored by `Pagy::Calendar::*` unit instances)_

`page: 3`
: Set it only to force the current `:page`. _(It is set automatically from the request param)_.

`client_max_limit: 1_000`
: Set the maximum `:limit` that the client is allowed to `request`. Higher requested `:limit`s are silently capped.

  **IMPORTANT** If falsey, the client cannot request any `:limit`.

`request: request || hash`
: Pagy tries to find the `Rake::Request` at `self.request`. Set it only when it's not directly available in your code (e.g., Hanami, standalone app, test,...). For example:
  ```ruby
  hash_request = { base_url: 'http://www.example.com',
                     path:     '/path',
                     params:   { 'param1' => 1234 }, # The string-keyed params hash from the request
                     cookie:   'xyz' }               # The 'pagy' cookie, only for keynav
  ```

{{ include "url-options" }}