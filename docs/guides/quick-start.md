---
label: Quick Start
order: 100
icon: rocket
---

#

## :icon-rocket-24:&nbsp;&nbsp;Quick Start

---

!!!question Migrating from another pagination gem?

Check the [Migration Guide](migration-guide) first

!!!

>>> Install

Prevent unexpected breaking changes in stable releases (see [omit the patch version](http://guides.rubygems.org/patterns/#pessimistic-version-constraint)):

```ruby Gemfile (stable)
gem 'pagy', '~> 43.4' # Omit the patch segment to avoid breaking changes
```

==- Try pagy...

- **In the Browser**
  - Run `pagy demo` in your terminal, and visit http://127.0.0.1:8000
- **In IRB**
  - Include the [Pagy::Console](../sandbox/console)

===

>>> Use it in your app

=== {{ include "snippets/mini-step" step: "2.1" }} Include the `pagy` method where you are going to use it _(usually ApplicationController)_:

```ruby
include Pagy::Method
```

=== {{ include "snippets/mini-step" step: "2.2" }} Use it to paginate any collection with any technique:

```ruby
@pagy, @records = pagy(:offset, Product.some_scope, **options) # :offset paginator
@pagy, @records = pagy(:keyset, Product.some_scope, **options) # :keyset paginator
@pagy, @records = pagy(...)
```

_Read the [Choose Right](choose-right) guide to pick the right [paginators](../toolbox/paginators#paginators) for your app_

=== {{ include "snippets/mini-step" step: "2.3" }} Render navigator tags and other helpers with the `@pagy` instance methods:

```erb
<%# Render navigation bar helpers with various types and styles %>
<%== @pagy.series_nav %>
<%== @pagy.series_nav_js(:bootstrap) %>
<%== @pagy.input_nav_js(:bulma) %>
<%== @pagy.info_tag %>
```
_See all the available [@pagy helpers](../toolbox/helpers)_

===
>>>
