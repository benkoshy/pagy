---
label: "Options"
icon: sliders
order: 100
---

#

## :icon-sliders-24:&nbsp;&nbsp;Options Hierarchy

---

!!! This page documents the options system
The actual options are documented alongside the [paginators](../paginators) and [helpers](../helpers) that use them.
!!!

Pagy has a top-down hierarchical options system that allows setting and overriding options at three different levels.

### Levels

>>> Global

- For example `Pagy::OPTIONS[:limit] = 10`.
- Set in the [pagy.rb initializer](initializer).
- The `Pagy::OPTIONS` are inherited by all paginators and helpers.
- You can set all kinds of options at the global level, no matter which is the destination downstream (i.e., paginator or helper).
- **IMPORTANT**: Freeze it after you are done in the initializer, for good safe practice.

>>> Paginator

- For example `pagy(paginator, collection, **options)`.
- The options passed to a paginator override the `Pagy::OPTIONS` set upstream for that instance.
- They are also inherited by all the helpers used by the instance

>>> Helper

- For example `@pagy.series_nav(**options)`.
- The options passed to a helper override all the upstream options for its output.
- The options consumed upstream are not affected.

>>>

!!!success
- **Keep options local**
  - For clarity, set options as close to where they're consumed as possible.
- **Widen the scope when needed**
  - Use higher-level options when they conveniently affect broader scopes.
!!!
