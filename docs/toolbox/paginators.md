---
label: "&nbsp;✳&nbsp;&nbsp;&nbsp;Paginators"
icon: database
order: 90
---

#

## ✳&nbsp;&nbsp;Paginators

||| The `pagy` Method

The `pagy` method provides a common interface to all paginators. Include it where you are going to paginate a collection _(usually in ApplicationController)_:

```ruby
include Pagy::Method
```
You can use it to paginate ANY collection, with ANY technique. For example:

```ruby
@pagy, @records = pagy(:offset, collection, **options)
@pagy, @records = pagy(:keyset, set, **options)
@pagy, @records = pagy(...)
```

- `:offset`, `:keyset`, etc. are symbols identifying the [paginator](#paginators). They implement the specific pagination.
- `@pagy` is the pagination instance. It provides all the instance helper methods to use in your code.
- `@records` are the records belonging to the requested page.

!!!info
The `pagy` method expects to find the rack request at `self.request`, however, you can also use pagy [outside controllers or views](/guides/how-to/#use-pagy-outside-controllers-or-views), or pass your [:request](#shared-options) option.
!!!

|||

### Paginators

!!!tip Read also the [Choose Right Guide](/guides/choose-right.md) to ensure good performance and smooth workflow.
!!!

The `paginators` are symbolic names of different pagination types/contexts (e.g., `:offset`, `:keyset`, `countless`, etc.). You pass the name to the `pagy` method and pagy will internally instantiate and handle the appropriate paginator class.

!!!warning Avoid instantiating Pagy classes directly
Instantiate paginator classes only if the documentation explicitly suggests it.
!!!

!!!success Paginators and classes are autoloaded only if used!
Unused code consumes no memory.
!!!

==- :icon-sliders:&nbsp; Shared Options

!!! Paginators may add and document specific [Options](configuration/options).
!!!

:icon-crosshairs-24:&nbsp; URL Options
: See [URL Options](/resources/urls#options)

`limit: 10`
: Specifies the number of items per page (default: `20`)

`max_pages: 500`
: Restricts pagination to only `:max_pages`. _(Ignored by `Pagy::Calendar::*` unit instances)_

`page: 3`
: Set it only to force the current `:page`. _(It is set automatically from the request param)_.

`client_max_limit: 1_000`
: Set the maximum `:limit` that the client is allowed to `request`. Higher requested `:limit`s are silently capped.
  : **IMPORTANT** If falsey, the client cannot request any `:limit`.

`request: request || hash`
: Pagy tries to find the `Rake::Request` at `self.request`. Set it only when it's not directly available in your code (e.g., Hanami, standalone app, test,...). For example:
  ```ruby
  hash_request = { base_url: 'http://www.example.com',
                   path:     '/path',
                   params:   { 'param1' => 1234 }, # The string-keyed params hash from the request
                   cookie:   'xyz' }               # The 'pagy' cookie, only for keynav
  ```

==- :icon-mention:&nbsp; Shared Readers

!!! Paginators may add and document specific Readers.
!!!

`page`
: The current page

`limit`
: The items per page

`in`
: The actual items in the page

`options`
: The options of the object

`next`
: The next page

==- :icon-stop:&nbsp; Shared Exceptions

!!! Paginators may add and document specific Exceptions.
!!!

`Pagy::OptionError`
: A subclass of `ArgumentError` that offers information to rescue invalid options.
  : For example: `rescue Pagy::OptionError => e`
  - `e.pagy` the pagy object
  - `e.option` the offending option symbol (e.g. `:page`)
  - `e.value` the value of the offending option (e.g. `-3`)

==- :icon-stop:&nbsp; Troubleshooting

||| Records may repeat in different pages or be missing

!!!danger Don't Paginate Unordered PostgreSQL Collections!
!!!

You can simply chain something like `.order(:id)` and fix the issue _(See [PostgreSQL Documentation](https://www.postgresql.org/docs/16/queries-limit.html#:~:text=When%20using%20LIMIT,ORDER%20BY))_
|||

===
