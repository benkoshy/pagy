---
label: JavaScript
icon: file-code
order: 80
---

#

## JavaScript Support

---

!!!warning 

The helpers and paginators suffixed with `*_js` **require** JavaScript support.
!!!

>>> Pick a format...

+++ pagy.mjs

!!!success

Good for apps **with** a minifier _(Sprockets, builers, ...)_

!!!

Make `Pagy` available in your JavaScript environment with...

```js application.js
import Pagy from "pagy.mjs"
```

+++ pagy.min.js

!!!success

Good for apps **without** a minifier _(Propshaft, Importmaps, ...)_

!!!

Make `Pagy` available in your JavaScript environment with...

```erb ERB template / HTML page
<%= javascript_include_tag "pagy.min.js" ...%>

<!-- or if your app does not provide helpers --> 
<script src="/path/to/pagy.min.js"></script>
```

+++ pagy.js

!!!warning Good **only** for pagy development / debugging

With inline sourcemap

!!!

+++

>>> Pick a configuration...

+++ Sync
 
!!!success Works with any app
!!!

The following statement will copy and keep synced the JavaScript file(s) in your own `app/javascript` dir _(or any dir you want use)_.

After that you should use them exactly as you use your own.

```rb [pagy.rb initializer](../toolbox/configuration/initializer)
# Use the pagy.* format you picked
Pagy.sync(:javascript, Rails.root.join('app/javascript'), 'pagy.*') if Rails.development?
```
==- Sync Task

If you prefer to sync manually or during an automation step, you can define your own task with a single line in the `Rakefile`, or `*.rake` file:

```rb
# Pagy::SyncTask.new(:javascript, destination, *targets)
Pagy::SyncTask.new(:javascript, Rails.root.join('app/javascript'), 'pagy.*')
```

and exec it with...

```sh
bundle exec rake pagy:sync:javascripts
```
===

+++ Pipeline

!!!success Works only with apps with an assets pipeline
!!!

```rb
Rails.application.config.assets.paths << Pagy::ROOT.join('javascript') 
```

+++

>>> Add the `Pagy.init` to an event...

+++ load

```js
window.addEventListener("load", Pagy.init)
```

+++ turbo:load

```js
window.addEventListener("turbo:load", Pagy.init)
```

+++ turbolinks:load

```js
window.addEventListener("turbolinks:load", Pagy.init)
```

+++ custom

```js
window.addEventListener("your-event", Pagy.init)
```

+++

>>>
