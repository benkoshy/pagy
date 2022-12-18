---
icon: versions-24
---

# CHANGELOG

## Breaking Changes

If you upgrade from version `< 5.0.0` see the following:

- [Breaking changes in version 6.0.0](#version-600)
- [Breaking changes in version 5.0.0](CHANGELOG_LEGACY.md#version-500)
- [Breaking changes in version 4.0.0](CHANGELOG_LEGACY.md#version-400)
- [Breaking changes in version 3.0.0](CHANGELOG_LEGACY.md#version-300)
- [Breaking changes in version 2.0.0](CHANGELOG_LEGACY.md#version-200)
- [Breaking changes in version 1.0.0](CHANGELOG_LEGACY.md#version-100)

## Deprecations

None

## Version 6.0.0

### Breaking changes
                           
Removed support for the deprecation of `5.0`:

- The `pagy_massage_params` method: use the `:params` variable set to a lambda `Proc` that does the same (but per instance). See [How to customize the params](https://ddnexus.github.io/pagy/how-to#customize-the-params).
- The `activesupport` core dependency: it will become an optional requirement if you use the calendar: add `gem 'activesuport'` to your Gemfile if your app doesn't use rails.
- The plain `Time` objects in the `:period` variable: use only `ActiveSupport::TimeWithZone` objects. 
- The `:offset` variable used by the `Pagy::Calendar::Week`: set the `Date.beginning_of_week` variable to the symbol of the first day of the week (e.g. `Date.beginning_of_week = :sunday`). Notice the default is `:monday` consistently with the ISO-8601 standard (and Rails).
- The `Pagy::DEFAULT[:elasticsearch_rails_search_method]`: use `Pagy::DEFAULT[:elasticsearch_rails_pagy_search]` instead.
- The `Pagy::DEFAULT[:searchkick_search_method]`: use `Pagy::DEFAULT[:searchkick_pagy_search`] instead.
- The `Pagy::DEFAULT[:meilisearch_search_method]`: use `Pagy::DEFAULT[:meilisearch_pagy_search]` instead.

#### Suggestions for a smooth removal of deprecations from pagy 5

- Upgrade to the latest version of pagy 5 first
- Run your tests or app
- Check the log for any deprecations message starting with '[PAGY WARNING]'
- Update your code as indicated by the messages
- Ensure that the log is now free from warnings
- Upgrade to pagy 6

### Changes

- ...

[LEGACY CHANGELOG >>>](CHANGELOG_LEGACY.md) 
