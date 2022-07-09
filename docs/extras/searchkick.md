---
title: Searchkick
categories:
- Backend Extras
- Search Extras
---
# Searchkick Extra

Paginates `Searchkick::Results` objects.

## Setup
See [extras](/docs/extras.md) for general usage info.

||| pagy.rb (initializer)
```ruby
require 'pagy/extras/searchkick'
Searchkick.extend Pagy::Searchkick # optional - see Active Mode
```
|||

### Modes
Choose between two modes: 

+++ Passive Mode
!!! Use when:
you already have a paginated `Searchkick::Results` object.
!!!

||| Controller
```ruby
@results = Model.search('*', page: 1, per_page: 10, ...) # already paginated
@pagy    = Pagy.new_from_searchkick(@results, ...)
```
|||

+++ Active Mode
!!! Use when:
you want to control the pagination.
!!!

||| Model
```ruby
extend Pagy::Searchkick
```
|||


||| Controller
```ruby
results         = Article.pagy_search(params[:q])
@pagy, @results = pagy_searchkick(results, items: 10)
```
|||


If using `Searchkick.pagy_search` then:

||| pagy (initializer)
```ruby
# config/initializers/pagy.rb
Searchkick.extend Pagy::Searchkick
```
|||

||| Controller
```ruby
results         = Searchkick.pagy_search(params[:q], models: [Article, Categories])
@pagy, @results = pagy_searchkick(results, items: 10) # Use `pagy_search` in place of `search`:
```
|||
+++


## Files
[!file searchkick.rb](https://github.com/ddnexus/pagy/blob/master/lib/pagy/extras/searchkick.rb)

## Passive mode

### Pagy.new_from_searchkick(results, vars)

**Accepts:**

* [`Searchkick::Results` object](https://www.rubydoc.info/github/ankane/searchkick/Searchkick/Results)
* [vars argument](./docs/api/pagy/#variables)

**Returns:**

* a pagy object

||| Controller
```ruby
Pagy.new_from_searchkick(results, vars)
```
|||


```ruby
@results = Model.search('*', page: 2, per_page: 10, ...)
@pagy    = Pagy.new_from_searchkick(@results, ...)
```
!!!warning Warning
`new_from_searchkick` sets: `:items`, `:page` and `:count` pagy variables from the `Searchkick::Results` object - so don't pass them in.

```ruby
@pagy = Pagy.new_from_searchkick(@results, {page: "no need to pass again"}) # No!
```
!!!


## Active Mode

## Pagy::Searchkick module

* Adds `pagy_search` singleton method to Model:

||| Model
```ruby
class AnyModel < etc
  extend Pagy::Searchkick
end

AnyModel.pagy_search(...) # e.g.
```
|||

!!! Use:
`pagy_search` in lieu of the standard `search` method.
!!!

### pagy_search(...)

**Accepts**:
* Same arguments as the `search` method.


**How does it work?** 

* `pagy_search` automatically merges the calculated `:page` and `:per_page` options and then 
* passes all arguments to the standard `search` method internally.

### Variables

| Variable                  | Description                                     | Default        |
|:--------------------------|:------------------------------------------------|:---------------|
| `:searchkick_pagy_search` | customizable name of the pagy search method     | `:pagy_search` |
| `:searchkick_search`      | customizable name of the original search method | `:search`      |

### Methods

* Adds the `pagy_searchkick` method to the `Pagy::Backend`.

!!! Use when:
*  you have to paginate a `Searchkick::Results` object. 
*  It adds a `pagy_searchkick_get_vars` sub-method, to enable customization of variables by overriding.
!!!

#### pagy_searchkick(pagy_search_args, vars={}})

* Similar to the generic `pagy` method, but specialized for Searchkick. (see the [pagy doc](/docs/api/backend.md#pagycollection-varsnil))

**Accepts:**

* Model.pagy_search(...)` result 

**Returns:**

* a paginated response. 

```ruby
@pagy, @results = pagy_searchkick(Model.pagy_search(params[:q]), ...)
...
@records = @results.results

# or directly with the collection you need (e.g. records)
@pagy, @records = pagy_searchkick(Model.pagy_search(params[:q]).results, ...)
```

#### pagy_searchkick_get_vars(array)

* Similar to the `pagy_get_vars` sub-method, but called only by the `pagy_searchkick` method. (see the [pagy_get_vars doc](/docs/api/backend.md#pagy_get_varscollection-vars)).
