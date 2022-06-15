---
title: Home
icon: home
---
# Basic Concepts

## Pagination is a simple task

It's fundamentally a series of integers. Creating thousands of objects for this task is akin to using a bazooka to swat a fly:

## Pagy keeps it simple

* No "declarative DSLs", 
* No "global pollution", 
* No special modules / adapters. 
* No nested modules, classes nor countless methods...

Checkout the core source - barely a lick more than 120 lines: [pagy.rb](https://github.com/ddnexus/pagy/blob/master/lib/pagy.rb), [pagy/backend.rb](https://github.com/ddnexus/pagy/blob/master/lib/pagy/backend.rb), [pagy/frontend.rb](https://github.com/ddnexus/pagy/blob/master/lib/pagy/frontend.rb) .

Simple means: small, and *performant*.

## Specialized code instead of generic helpers

Pagy produces its own HTML, URLs, pluralization and interpolation. Unlike other gems it does not use generic helpers ( e.g. `tag`, `link_to`, `url_for`, `I18n.t`, ...), which are typically slower and less performant, than pagy's hyper-optimized and specialized methods - which are turbo-charged for performance.

## Stay away from the models

**Paginating is not business logic**: it has nothing to do with data, but rather how you decide to _present_ it ... one page at the time, n items per page... Should this _presentation_ logic be really added to your models? 

**Every collection knows already how to paginate itself**: that's what OFFSET and LIMIT in DBs are for! You decide the limit (the items per page) and Pagy (or yourself) can calculate the offset with simple arithmetic: `offset = items * (page - 1)`. That's not rocket science! 

Ignoring these rules has drawbacks in terms of performance, memory, maintenance, complexity and usability (See: [Gems Comparison page](http://ddnexus.github.io/pagination-comparison)).

## No rails engine needed

* Works in all frameworks.
* Just a few lines of ruby needed is all that's required.

## Really agnostic pagination

The pagination logic is contained in one micro-class that creates a micro-object of less than 3k: it works perfectly, knowing **absolutely nothing** about your environment. _(see the [source](https://github.com/ddnexus/pagy/blob/master/lib/pagy.rb))_

You could even use it directly (without using any other Pagy code) in a small partial template that you could write in 5 minutes (~15 lines), using the regular helpers provided by your framework. It would still work a few times faster than other pagination gems based on my estimates.

## Really easy to customize

If options are not enough, you have several specialized [extras](docs/extras.md), and if that is still not enough, any other special customization is _one step away_. You include and override any method right where you use it. 

What could be easier?
