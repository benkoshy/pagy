---
title: Javascript
category: Tools
image: null
---

# Javascript

## Overview

### Helpers Available

Choose from the following JS helpers / CSS frameworks:

+++ pagy*_nav_js

![bootstrap_nav_js](../assets/images/bootstrap_nav_js-g.png)
* Shows a responsive `bootstrap_nav_js` ([`bootstrap`extra](../extras/bootstrap)) helper. 

<details>
  <summary>
    Other supported CSS frameworks:
  </summary>

- `pagy_bootstrap_nav_js`
- `pagy_bulma_nav_js`
- `pagy_foundation_nav_js`
- `pagy_materialize_nav_js`
- `pagy_semantic_nav_js`
- `pagy_nav_js` (no styling)
</details>

+++ pagy*_combo_nav_js

![bootstrap_combo_nav_js](../assets/images/bootstrap_combo_nav_js-g.png)

* Shows a `bootstrap_combo_nav_js` ([`bootstrap`extra](../extras/bootstrap)) helper.
* Navigation and pagination info combined in a single element.
* Fastest and lightest `nav` on modern environments, recommended for [maximizing Performance](../how-to.md#maximize-performance).

<details>
  <summary>
    Other CSS frameworks are supported:
  </summary>
- `pagy_combo_nav_js`
- `pagy_bootstrap_combo_nav_js`
- `pagy_bulma_combo_nav_js`
- `pagy_foundation_combo_nav_js`
- `pagy_materialize_combo_nav_js`
- `pagy_semantic_combo_nav_js`
</details>

+++ pagy_items_selector_js

To be done: 
(i) add a picture
(ii) list the methods available.
(iii) link to further information
+++

### Why bother with JS helpers?

1. Better performance and resource usage (see [Maximizing Performance](../how-to.md#maximize-performance))
2. Client-side rendering
3. Optional responsiveness

### How do they work?

* `pagy*_js` helpers render client-side. 
* They serve a minimal HTML tag that: (i) contains a `data-pagy` attribute, which (ii) combined with [a javascript file](https://github.com/ddnexus/pagy/tree/master/lib/javascripts) (that you must include in your assets - pick the one that best suits), will render in the browser.
* API Summary: All files expose a `Pagy` object, with just one function: `init()`. You can access any of them with the following: `Pagy.root.join('javascripts', '......')`.


**Notice** The javascript file is required only for the `pagy*_js` helpers. Just using `'data-remote="true"'` without any `pagy*_js` helper works without any javascript file.

### Caveats

!!!success For Better Performance: Use `oj` Gem
1. `bundle add oj`.
2. Boosts performance for js-helpers *only*.
!!!

!!!warning HTML Fallback
If Javascript is not supported / disabled, the `js` helpers will be useless. Consider a fallback for such browsers: 

```erb
<noscript><%== pagy_nav(@pagy) %></noscript>
```
!!!

!!!danger Overriding `*_js` helpers?
Don't: API is not stable.
!!!

# Javascript Navs

## Installation instructions

1. Pick a Javascript File 
2. Load the Javascript assets.
3. Add the relevant extra
4. Use JS helper in a View

See [extras](../extras.md) for general usage info.

#### 1. Pick a JS File

+++ 1. pagy-module.js (Modern)
* For use with modern build tools.  
* ES6 module.
* Use as default.
* Reference: [pagy-module.js](https://github.com/ddnexus/pagy/blob/master/lib/javascripts/pagy-module.js).

+++ 2. pagy.js (Old Browsers)
* Use for old browser compatibility.
* it's an [IIFE](https://developer.mozilla.org/en-US/docs/Glossary/IIFE); 
* polyfilled and minified (~2.9k).
* Reference: [pagy.js](https://github.com/ddnexus/pagy/blob/master/lib/javascripts/pagy.js): 

<details>
<summary> Browser compatibility list: </summary>

- and_chr 96
- and_ff 95
- and_qq 10.4
- and_uc 12.12
- android 96
- baidu 7.12
- chrome 97
- chrome 96
- chrome 95
- chrome 94
- edge 97
- edge 96
- firefox 96
- firefox 95
- firefox 94
- firefox 91
- firefox 78
- ie 11
- ios_saf 15.2
- ios_saf 15.0-15.1
- ios_saf 14.5-14.8
- ios_saf 14.0-14.4
- ios_saf 12.2-12.5
- kaios 2.5
- op_mini all
- op_mob 64
- opera 82
- opera 81
- safari 15.2
- safari 15.1
- safari 14.1
- safari 13.1
- samsung 15.0
- samsung 14.0

**Notice**: You can generate custom targeted `pagy.js` files for the browsers you want to support by changing the [browserslist](https://github.com/browserslist/browserslist) query in `src/package.json`, then compile it with `npm run build -w src`.

</details>

+++ 3. pagy-dev.js (Debugging)
* Use for **debugging only**.
* Reference: [pagy-dev.js](https://github.com/ddnexus/pagy/blob/master/lib/javascripts/pagy-dev.js): 

<details>
<summary>
  Why Debugging Only?
</summary>

* Large size,
* contains source map to debug typescript.
* works only on new browsers.
</details>
+++

#### 2a. Load Javascript

+++ Sprockets / Asset Pipeline
```ruby
# config/initializers/pagy.rb
Rails.application.config.assets.paths << Pagy.root.join('javascripts') # uncomment.
```
+++ Modern Build tools
```js
// Some initialisation file:
import Pagy from "pagy-module";
```
+++ Importmaps

```ruby
# config/initializers/pagy.rb
Rails.application.config.assets.paths << Pagy.root.join('javascripts') #uncomment
```

```js
//// app/assets/config/manifest.js - add sprockets directive:
//= link pagy-module.js
```

```ruby
# config/importmap.rb
pin 'pagy-module'
```
+++ Propshaft
```ruby
# config/initializers/pagy.rb
Rails.application.config.assets.paths << Pagy.root.join('javascripts')
```
+++ Other
Ensure `Pagy.root.join('javascripts', 'pagy.js')` is served.
+++

#### 2b. Initialise Javascript

+++ Stimulus JS 
```js
// pagy_initializer_controller.js
import { Controller } from "@hotwired/stimulus"
import Pagy from "pagy-module"  // if using webpack, esbuild, modern build tools etc.
                                // if using sprockets, you can remove above line

export default class extends Controller {
  connect() {
    Pagy.init(this.element)
  }
}

// Ensure Pagy object has been loaded (see loading instructions above)
```

```erb
<div data-controller="pagy-initializer">
  <%== pagy_nav_js(@pagy) %>
</div>
```

+++ Plain Javascript
```js
// ./app/assets/builds/application.js       // Or:
// ./app/assets/javascripts/application.js

//= require pagy
window.addEventListener(load, Pagy.init); // or
window.addEventListener(turbolinks:load, Pagy.init); // turbolinks
window.addEventListener(turbo:load, Pagy.init); // turbo, or listen for your own event
```
+++ Turbolinks
Wow! Yet another tab :+1:
+++ Turbo (via Hotwire)
Wow! Yet another tab :+1:
+++

Consider deleting: 

The strategy might vary, depending on what you're using: sprockets / or bundlers like (webpack-esbuild-rollup etc) / importmaps / propshaft etc - see [Javascript Readme Instructions](https://github.com/ddnexus/pagy/blob/master/lib/javascripts/README.md) for installation and initialization details.

#### 2. Add the relevant extra

In the `pagy.rb` initializer, require the specific extra for the style you want to use:

```ruby
# you only need one of the following extras
require 'pagy/extras/bootstrap'
require 'pagy/extras/bulma'
require 'pagy/extras/foundation'
require 'pagy/extras/materialize'
require 'pagy/extras/navs'
require 'pagy/extras/semantic'
require 'pagy/extras/uikit'
```

This will make available, the below helpers:

#### 3. Use the JS helper in a View

Use one of the `pagy*_nav_js` helpers in any view:

```erb
<%== pagy_nav_js(@pagy) %>
<%== pagy_bootstrap_nav_js(@pagy) %>
<%== pagy_bulma_nav_js(@pagy) %>
<%== pagy_foundation_nav_js(@pagy) %>
<%== pagy_materialize_nav_js(@pagy) %>
<%== pagy_semantic_nav_js(@pagy) %>
```

## API Details

### Variables

| Variable | Description                                                        | Default |
|:---------|:-------------------------------------------------------------------|:--------|
| `:steps` | Hash variable to control multiple pagy `:size` at different widths | `false` |

### :steps

The `:steps` is an optional non-core variable used by the `pagy*_nav_js` navs. If it's `false`, the `pagy*_nav_js` will behave exactly as a static `pagy*_nav` respecting the single `:size` variable, just faster and lighter. If it's defined as a hash, it allows you to control multiple pagy `:size` at different widths.

You can set the `:steps` as a hash where the keys are integers representing the widths in pixels and the values are the Pagy `:size` variables to be applied for that width.

As usual, depending on the scope of the customization, you can set the variables globally or for a single pagy instance, or even pass it to the `pagy*_nav_js` helper as an optional keyword argument.

For example:

```ruby
# globally
Pagy::DEFAULT[:steps] = { 0 => [2,3,3,2], 540 => [3,5,5,3], 720 => [5,7,7,5] }

# or for a single instance
pagy, records = pagy(collection, steps: { 0 => [2,3,3,2], 540 => [3,5,5,3], 720 => [5,7,7,5] } )

# or use the :size as any static pagy*_nav
pagy, records = pagy(collection, steps: false )
```

```erb
or pass it to the helper
<%== pagy_nav_js(@pagy, steps: {...}) %>
```

The above statement means that from `0` to `540` pixels width, Pagy will use the `[2,3,3,2]` size, from `540` to `720` it will use the `[3,5,5,3]` size and over `720` it will use the `[5,7,7,5]` size. (Read more about the `:size` variable in the [How to control the page links](../how-to.md#control-the-page-links) section).

**IMPORTANT**: You can set any number of steps with any arbitrary width/size. The only requirement is that the `:steps` hash must contain always the `0` width or a `Pagy::VariableError` exception will be raised.

### Setting the right sizes

Setting the widths and sizes can create a nice transition between widths or some apparently erratic behavior.

Here is what you should consider/ensure:

1. The pagy size changes in discrete `:steps`, defined by the width/size pairs.

2. The automatic transition from one size to another depends on the width available to the pagy nav. That width is the _internal available width_ of its container (excluding eventual horizontal padding).

3. You should ensure that - for each step - each pagy `:size` produces a nav that can be contained in its width.

4. You should ensure that the minimum internal width for the container div be equal (or a bit bigger) to the smaller positive width. (`540` pixels in our previous example).

5. If the container width snaps to specific widths in discrete steps, you should sync the quantity and widths of the pagy `:steps` to the quantity and internal widths for each discrete step of the container.

#### Javascript Caveats

In case of a window resize, the `pagy_*nav_js` elements on the page are re-rendered (when the container width changes), however if the container width changes in any other way that does not involve a window resize, then you should re-render the pagy element explicitly. For example:

```js
document.getElementById('my-pagy-nav-js').render();
```

# Javascript Combo Navs

## Synopsis

See [extras](../extras.md) for general usage info.

In the `pagy.rb` initializer, require the specific extra for the style you want to use:

```ruby
# you only need one of the following extras
require 'pagy/extras/bootstrap'
require 'pagy/extras/bulma'
require 'pagy/extras/foundation'
require 'pagy/extras/materialize'
require 'pagy/extras/navs'
require 'pagy/extras/semantic'
require 'pagy/extras/uikit'
```

Use the `pagy*_combo_nav_js` helpers in any view:

```erb
<%== pagy_combo_nav_js(@pagy, ...) %>
<%== pagy_bootstrap_combo_nav_js(@pagy, ...) %>
<%== pagy_bulma_combo_nav_js(@pagy, ...) %>
<%== pagy_foundation_combo_nav_js(@pagy, ...) %>
<%== pagy_materialize_combo_nav_js(@pagy, ...) %>
<%== pagy_semantic_combo_nav_js(@pagy, ...) %>
```

## Methods

### pagy*_nav_js(pagy, ...)

The method accepts also a few optional keyword arguments:

- `:pagy_id` which adds the `id` HTML attribute to the `nav` tag
- `:link_extra` which add a verbatim string to the `a` tag (e.g. `'data-remote="true"'`)
- `:steps` the [:steps](#steps) variable

**CAVEATS**: the `pagy_bootstrap_nav_js` and `pagy_semantic_nav_js` assign a class attribute to their links, so do not add another class attribute with the `:link_extra`. That would be illegal HTML and ignored by most browsers.

### pagy*_combo_nav_js(pagy, ...)

The method accepts also a couple of optional keyword arguments:

- `:pagy_id` which adds the `id` HTML attribute to the `nav` tag
- `:link_extra` which add a verbatim string to the `a` tag (e.g. `'data-remote="true"'`)

**CAVEATS**: the `pagy_semantic_combo_nav_js` assigns a class attribute to its links, so do not add another class attribute with the `:link_extra`. That would be illegal HTML and ignored by most browsers.

# Using AJAX

If you AJAX-render any of the javascript helpers mentioned above, you should also execute `Pagy.init(container_element);` in the javascript template. Here is an example for an AJAX-rendered `pagy_bootstrap_nav_js`:

In `pagy_remote_nav_js` controller action (notice the `link_extra` to enable AJAX):

```ruby
def pagy_remote_nav_js
  @pagy, @records = pagy(Product.all, link_extra: 'data-remote="true"')
end
```

In `pagy_remote_nav_js.html.erb` template for non-AJAX render (first page-load):

```erb
<div id="container">
  <%= render partial: 'nav_js' %>
</div>
```

In `_nav_js.html.erb` partial shared for AJAX and non-AJAX rendering:

```erb
<%== pagy_bootstrap_nav_js(@pagy) %>
```

In `pagy_remote_nav_js.js.erb` javascript template used for AJAX:

```js
$('#container').html("<%= j(render 'nav_js')%>");
Pagy.init(document.getElementById('container'));
```

**IMPORTANT**: The `document.getElementById('container')` argument will re-init the pagy elements just AJAX-rendered in the container div. If you miss it, it will not work.
