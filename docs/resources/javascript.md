---
label: JavaScript
icon: file-code
order: 80
---

#

## :icon-file-code-24:&nbsp;&nbsp;JavaScript Support

---

!!!tip Add the `oj` gem to your gemfile
It is not a requirement, but if present, the pagy `JSON` generation will be faster.

!!!

<br>

### Setup Steps

<br>

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

{{ include "snippets/pick-a-conf" resource: ":javascript" resource_dir: "javascripts" remote_dir: "app/javascript" }}

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
