---
title: Searchkick
categories:
- Backend Extras
- Search Extras
---
# Searchkick Extra

This extra enables you to paginate `Searchkick::Results` objects. You have two choices:

1. create a `Pagy` object out of an (already paginated) `Searchkick::Results` object ([Passive Mode](#1-passive-mode)), OR 
2. create `Pagy` and `Searchkick::Results` objects from the backend params ([Active Mode](#2-active-mode)).

## Synopsis

See [extras](/docs/extras.md) for general usage info.

||| pagy.rb (initializer)
```ruby
# e.g. config/initializers/pagy.rb
require 'pagy/extras/searchkick'
Searchkick.extend Pagy::Searchkick   # optional
```
|||

### 1. Passive mode

If you already have a paginated `Searchkick::Results` object, you can get the `Pagy` object out of it:

||| # any_controller.rb
```ruby
@results = Model.search('*', page: 1, per_page: 10, ...)
@pagy    = Pagy.new_from_searchkick(@results, ...)
```
|||

### 2. Active Mode

If you want Pagy to control the pagination: 

i. get the page from the params, and 
ii. return both the `Pagy` and the `Searchkick::Results` objects automatically (from the backend params):

||| any_model.rb
```ruby
extend Pagy::Searchkick
```
|||

In a controller use `pagy_search` in place of `search`:

||| any_controller.rb
```ruby
results         = Article.pagy_search(params[:q])
@pagy, @results = pagy_searchkick(results, items: 10)
```
|||

#### Searchkick.search

Extend `Searchkick` module if you are going to use `Searchkick.pagy_search`:

||| pagy.rb (initializer)
```ruby
# e.g. config/initializers/pagy.rb
Searchkick.extend Pagy::Searchkick
```
|||

Use `pagy_search` in place of `search`:

||| any_controller.rb
```ruby
results         = Searchkick.pagy_search(params[:q], models: [Article, Categories])
@pagy, @results = pagy_searchkick(results, items: 10)
```
|||

## Files

[!file searchkick.rb](https://github.com/ddnexus/pagy/blob/master/lib/pagy/extras/searchkick.rb)

## API

## Passive mode

### Pagy.new_from_searchkick(results, vars = {})

This constructor accepts a `Searchkick::Results` as the first argument, plus the usual [optional variable hash](/docs/api/pagy/#variables). It sets the `:items`, `:page` and `:count` pagy variables extracted/calculated out of the `Searchkick::Results` object.

||| any_controller.rb
```ruby
@results = Model.search('*', page: 2, per_page: 10, ...)
@pagy    = Pagy.new_from_searchkick(@results, ...)
```
|||


!!!info Must Manually Manage Params
You must manually manage all the params for your search, but the method extracts the `:items`, `:page` and `:count` from the results object, so you don't need to pass that in again.

```ruby
@pagy = Pagy.new_from_searchkick(@results, {count: 123}) # no need to pass in count
```
!!!

## Active Mode

### Pagy::Searchkick module

Extend your model with the `Pagy::Searchkick` micro-module:

```ruby
extend Pagy::Searchkick
```

The `Pagy::Searchkick` adds the `pagy_search` class method that you must use in place of the standard `search` method when you want to paginate the search response.

### pagy_search(...)

This method accepts the same arguments of the `search` method and you must use it in its place. This extra uses it in order to capture the arguments, automatically merging the calculated `:page` and `:per_page` options before passing them to the standard `search` method internally.

## Variables

| Variable                  | Description                                     | Default        |
|:--------------------------|:------------------------------------------------|:---------------|
| `:searchkick_pagy_search` | customizable name of the pagy search method     | `:pagy_search` |
| `:searchkick_search`      | customizable name of the original search method | `:search`      |

## Methods

This extra adds the `pagy_searchkick` method to the `Pagy::Backend` to be used when you have to paginate a `Searchkick::Results` object. It also adds a `pagy_searchkick_get_vars` sub-method, used for easy customization of variables by overriding.

### pagy_searchkick(pagy_search_args, vars={}})

This method is similar to the generic `pagy` method, but specialized for Searchkick. (see the [pagy doc](/docs/api/backend.md#pagycollection-varsnil))

It expects to receive a `Model.pagy_search(...)` result and returns a paginated response. You can use it in a couple of ways:

```ruby
@pagy, @results = pagy_searchkick(Model.pagy_search(params[:q]), ...)
...
@records = @results.results

# or directly with the collection you need (e.g. records)
@pagy, @records = pagy_searchkick(Model.pagy_search(params[:q]).results, ...)
```

### pagy_searchkick_get_vars(array)

This sub-method is similar to the `pagy_get_vars` sub-method, but it is called only by the `pagy_searchkick` method. (see the [pagy_get_vars doc](/docs/api/backend.md#pagy_get_varscollection-vars)).
