---
title: Pagy::Keyset
category:
  - Feature
  - Class
---

# Pagy::Keyset

Implement wicked-fast, no-frills keyset pagination for big data.

!!!  

The class API is documented here, however you should not need to use this
class directly because it is required and used internally by the [keyset extra](/docs/extras/keyset.md)

!!!

## Concept

The "Keyset" pagination, also known as "SQL Seek Method" (and often, improperly called "Cursor" pagination) is a tecnique that totally avoids the slowness of querying pages deep into the collection (i.e. when the `offset` is a big number).

This tecnique comes with that huge advantage and a set of limitations that makes it particularly useful for APIs and pretty useless for UIs. 

!!!info

With the regular `offset` pagination, your UI can perfectly handle also big data, by simply limiting the `:max_pages` (variable) 
that allows to serve, effectively avoiding the problem, albeit limiting the browsing to a the initial pages of the collection. 
When you have to serve millions of records, that is not an option, so that is why you use pagy keyset. 

!!!

### Keyset Glossary

- `set`: uniquely ordered `ActiveRecord::Relation` or `Sequel::Dataset`
- `keyset`: the hash of column/order-direction pairs used to order the `set`. It works similarly to a composite primary `key` 
  for the ordered table, for that reason the concatenation of the values of the ordered columns must be unique for each record.
- `cursor`: the hash of `keyset` attributes of the last retrieved record
- `page`: the `Base64.urlsafe_encoded` `cursor` that can be passed around as a param

## Overview

Pagy Keyset pagination does not waste resources and code complexity checking your scope nor your table config at every request.

That means that you have to be sure that your scope is right, and that your tables have the right indices (for performance). You do it once during development, and pagy will be fast at each request. ;)

### Constraints

Like any keyset pagination:
  - You don't know the record count nor the page count
  - The pages have no number
  - You cannot jump to an arbitrary page
  - You can only get the next page
  - You know that you reached the end of the collection when `pagy.next.nil?` 
     
Similarly to the Pagy Offset pagination:
  - You paginate only forward. To go backward... just reverse the order
    in your scope and paginate forward in the reversed order.

Besides:
  - In order to save resources and complexity: you don't know the previous and the last page.
  - The `set` must be uniquely ordered: you can add the primary key (usually `:id`) as the last order column as a tie-breaker if 
    the concatenation of the ordered columns might not be unique
  - You should add the best index for your ordering strategy for performance. The keyset pagination would work even without any 
      index, but it defeats its purpose of speed.

### ORMs

`Pagy::Keyset` implements the classes for `ActiveRecord::Relation` and `Sequel::Dataset` sets.


## How pagy keyset works

You pass an uniquely ordered `set`, and `Pagy::Keyset` queries the page of records, keeping track of the last retrieved record by 
encoding the information into the `page` param of the `next` URL. At each request the `:page` is decoded and used to prepare a `when` clause that excludes the records retrived up to that point and includes the number of requested `:items`.

## Methods

==- `Pagy::Keyset.new(set, **vars)`

The constructor takes the `set`, and an optional hash of [variables](#variables). 

==- `next`

The next `page`, i.e. the encoded `cursor` used to exclude the records retrieved up to that point .

==- `records`

The `Array` of records in the current page.

===

## Variables

=== `:page`

The current `page`. Default `nil` for the first page.

=== `:items`

The number of `:items` per page. Default `DEFAULT[:items]`. You can use the [items extra](/docs/extras/items.md) to get it automatically from the request param.

=== `:row_comparison`

Boolish variable that enables the row comparison query for same-direction keysets (use B-tree indices for performance). Default `nil`.

==- `:after_where`

A lambda that you can use to override the query automatically generated and applied by pagy to the `set` in order to exclude 
the already retrieved records. If defined, pagy will call it passing the `set` and the `cursor`. Use it for DB-specific extra 
optimization if you know what you are doing. For example:

```ruby
after_where = lambda do |set, cursor|
    set.where(literal_after_query, **cursor)
end
```
 
=- `:typecast_cursor`

A lambda that you can use to override the automatic typecasting of your ORM. For example: the sqlite DB stores date and times 
as strings, and the query interpolation may fail composing and comparing string dates. The `typecast_cursor` is an effective 
last-resort option when fixing the typecasting in your models and/or the data your storage is not convenient.

```ruby
typecast_cursor = lambda do |cursor| 
  cursor[:birthdate] = DateTime.parse(cursor[:birthdate]).strftime('%F %T')
  cursor
end
```

===
