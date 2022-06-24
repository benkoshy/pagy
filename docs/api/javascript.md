---
title: Javascript
category: Tools
image: null
---

# Javascript

## Overview

### What's Available?

Choose from the following JS helpers / CSS framework flavours:

1. pagy*_nav_js
2. pagy*_combo_nav_js
3. pagy_items_selector_js

+++ pagy*_nav_js

![bootstrap_nav_js](../assets/images/bootstrap_nav_js-g.png)

<details>
  <summary>
  Helpers for other CSS frameworks:
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

* Navigation and pagination info combined.

<details>
  <summary>
    Helpers for other CSS frameworks:
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

### Why use JS helpers?

1. Better performance and resource usage (see [Maximizing Performance](../how-to.md#maximize-performance))
2. Client-side rendering
3. Optional responsiveness

### How do they work?

All `pagy*_js`helpers serve a minimal HTML tag which: 
  - contains a `data-pagy` attribute, which 
  - combined with [a served javascript file](https://github.com/ddnexus/pagy/tree/master/lib/javascripts) ([pick one](#1-pick-a-js-file) that best suits), creates + renders the requested components (`pagy*_nav_js`, `pagy*_combo_nav_js` or `pagy_items_selector_js`).


```js
// representative of all JS files
const Pagy = (() => {    
    return {                
        init(arg) {  
            // (1) search for a pagy-data attribute (created by pagy*_js helpers)
            // (2) create elements and render in browser.            
        }
    };
})();
export default Pagy;
```

**Notice** The javascript file is required only for the `pagy*_js` helpers. Just using `'data-remote="true"'` without any `pagy*_js` helper works without any javascript file.


## API Details

### Variables

| Variable | Description                                                        | Default |
|:---------|:-------------------------------------------------------------------|:--------|
| `:steps` | Hash variable to control multiple pagy `:size` at different widths | `false` |

#### :steps

=== Summary 
* Allows you to control the "size" of `pagy*_nav_js` nav links, depending on the size of a screen: 
* Small screens: Show less, large screens: show more. You can control this:

![Image showing - Visual explanation of Steps](../assets/images/steps-explanation.png)
=== 
==- Detailed Explanation
* `:steps`: an optional non-core variable used by `pagy*_nav_js` navs. 

```rb
pagy, records = pagy(collection, steps: false ) # if false
```

If `false`, the `pagy*_nav_js` will behave exactly as a static `pagy*_nav` respecting the single `:size` variable, just faster and lighter. 

If a hash, you can control multiple pagy `:size` at different widths:

* keys are integers representing widths in pixels,
* values are the Pagy `:size` variables, applied to that width.
* you can customise the scope: e.g. global, an instance level, or even at the the `pagy*_nav_js` helper as an optional keyword argument - e.g.:

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

##### What does it mean?

* From `0` to `540` pixels width, Pagy will use the `[2,3,3,2]` size, 
* from `540` to `720` it will use the `[3,5,5,3]` size and over 
* `720` it will use the `[5,7,7,5]` size. 

(Read more about the `:size` variable in the [How to control the page links](../how-to.md#control-the-page-links) section).

!!!warning Steps hash must contain `0` width
`:steps` hash must contain always the `0` width or a `Pagy::VariableError` exception will be raised.
!!!

##### Setting the right sizes

Ensure:

1. The pagy size changes in discrete `:steps`, defined by the width/size pairs.

2. The automatic transition from one size to another depends on the width available to the pagy nav. That width is the _internal available width_ of its container (excluding eventual horizontal padding).

3. For each step - each pagy `:size` produces a nav that can be contained in its width.

4. The minimum internal width for the container div be equal (or a bit bigger) to the smaller positive width. (`540` pixels in our previous example).

5. If the container width snaps to specific widths in discrete steps, sync the quantity and widths of the pagy `:steps` to the quantity and internal widths for each discrete step of the container.
===

### Methods

#### pagy*_nav_js(pagy, ...)

Optional keyword arguments:

- `:pagy_id`: adds the `id` HTML attribute to the `nav` tag
- `:link_extra` adds a verbatim string to the `a` tag (e.g. `'data-remote="true"'`)
- `:steps` the [:steps](#steps) variable

**CAVEATS**: the `pagy_bootstrap_nav_js` and `pagy_semantic_nav_js` assign a class attribute to their links, so do not add another class attribute with the `:link_extra`. That would be illegal HTML and ignored by most browsers.

#### pagy*_combo_nav_js(pagy, ...)

Optional keyword arguments:

- `:pagy_id`: adds the `id` HTML attribute to the `nav` tag
- `:link_extra` add a verbatim string to the `a` tag (e.g. `'data-remote="true"'`)


!!!danger Illegal HTML - Class added to `pagy_semantic_combo_nav_js`
* Do not add a class attribute to `pagy_semantic_combo_nav_js`: 

```rb
pagy_semantic_combo_nav_js(@pagy, link_extra: 'class="do-not-do-this"'')
```

* It will be ignored, and will be illegal HTML.
!!!

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

+++ Modern Build tools
All strategies look in the `$(bundle show 'pagy')/lib/javascripts` gem installation path:

==- Esbuld
In `package.json`, prepend the `NODE_PATH` environment variable to the `scripts.build` command:

```json
{
  "build": "NODE_PATH=\"$(bundle show 'pagy')/lib/javascripts\" <your original command>"
}
```
===

==- Webpack
In `package.json`, prepend the `PAGY_PATH` environment variable to the `scripts.build` command:

```json
{
  "build": "PAGY_PATH=\"$(bundle show 'pagy')/lib/javascripts\" <your webpack command>"
}
```

In `webpack.confg.js`, add the `resolve.modules` array:

```js
module.exports = {
  ...,                          // your original config
  resolve: {                    // add resolve.modules
    modules: [
      "node_modules",           // node_modules dir
      process.env.PAGY_PATH     // pagy dir
    ]
  }
}
```
===

==- Rollup
In `package.json`, prepend the `PAGY_PATH` environment variable to the `scripts.build` command:

```json
{
  "build": "PAGY_PATH=\"$(bundle show 'pagy')/lib/javascripts\" <your rollup command>"
}
```

In `rollup.confg.js`, configure the `plugins[resolve]`:

```js
export default {
  ...,                                    // your original config
  plugins: [
    resolve({
              moduleDirectories: [        // add moduleDirectories
                "node_modules",           // node_modules dir
                process.env.PAGY_PATH     // pagy dir
              ] 
    })
  ]
}
```
===

!!!primary Javascript packages Not Published
It's difficult to sync javascript versions to gem versions. The above solutions obviate this difficulty.
!!!

+++ Sprockets
```ruby
# config/initializers/pagy.rb
Rails.application.config.assets.paths << Pagy.root.join('javascripts') # uncomment.
```

In your `manifest.js` file (or `application.js` file if using older versions of sprockets): 

```js
//= require pagy
```
And initialize Pagy any way you like (see below):
+++ Importmaps

```ruby
# config/initializers/pagy.rb
Rails.application.config.assets.paths << Pagy.root.join('javascripts') #uncomment
```

Add sprockets directive e.g. in `app/assets/config/manifest.js`:

```js
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

```erb
<-- e.g. some view: appliciation.html.erb -->
<%= javascript_include_tag "pagy" %>
```
And initialize Pagy any way you like (see below):

+++ Any Ruby Framework
* Ensure `Pagy.root.join('javascripts', 'pagy.js')` is served.
* Initialize Pagy any way you like (see below):
+++

#### 2b. Initialise Javascript

+++ Stimulus JS
```js
// pagy_initializer_controller.js
import { Controller } from "@hotwired/stimulus"
import Pagy from "pagy-module"  // if using sprockets, you can remove above line, but make sure you have the appropriate directive if your manifest.js file.

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

+++ Other Initialisation Strategies
```js
import Pagy from "pagy-module" // if you choose pagy-module.js 
                               // if you choose pagy.js then make sure this IIFE is loaded.

window.addEventListener(load, Pagy.init); // In any javascript file that is served.
window.addEventListener(turbo:load, Pagy.init); // Turbo
window.addEventListener(turbolinks:load, Pagy.init); // turbolinks

window.addEventListener(yourEventListener, Pagy.init); // custom listener
```
+++

#### 2. Add the relevant extra

In your `pagy.rb` initializer, choose your style:

```ruby
# e.g. config/initializers/pagy.rb 
# pick ONLY one:
require 'pagy/extras/bootstrap'
require 'pagy/extras/bulma'
require 'pagy/extras/foundation'
require 'pagy/extras/materialize'
require 'pagy/extras/semantic'
require 'pagy/extras/uikit'
require 'pagy/extras/navs' # no CSS framework
```

This will make available, the below helpers:

#### 3. Use a JS Helper in a View:

+++ pagy*_nav_js
```erb
<-- Use just one: -->
<%== pagy_bootstrap_nav_js(@pagy) %>
<%== pagy_bulma_nav_js(@pagy) %>
<%== pagy_foundation_nav_js(@pagy) %>
<%== pagy_materialize_nav_js(@pagy) %>
<%== pagy_semantic_nav_js(@pagy) %>
<%== pagy_nav_js(@pagy) %> <-- No style -->
```
+++ pagy*_combo_nav_js
```erb
<-- Use just one: -->
<%== pagy_bootstrap_combo_nav_js(@pagy, ...) %>
<%== pagy_bulma_combo_nav_js(@pagy, ...) %>
<%== pagy_foundation_combo_nav_js(@pagy, ...) %>
<%== pagy_materialize_combo_nav_js(@pagy, ...) %>
<%== pagy_semantic_combo_nav_js(@pagy, ...) %>
<%== pagy_combo_nav_js(@pagy, ...) %> <-- No style -->
```
+++



## Using AJAX

If you AJAX-render any javascript helper, you must reinitialise the component: `Pagy.init(container_element);` 

If you're using Stimulus JS, this will be handled automatically, once it's inserted into the document. But if you're not, consider the following AJAX-rendered `pagy_bootstrap_nav_js` example:

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
Pagy.init(document.getElementById('container')); // don't forget to reinitialize - otherwise it won't work
```
## Caveats

!!!success For Better Performance: Use `oj` Gem
1. `bundle add oj`.
2. Boosts performance for js-helpers *only*.
!!!

!!!warning HTML Fallback
If Javascript is disabled, the `js` helpers will be useless. 
Consider a fallback for such browsers: 

```erb
<noscript><%== pagy_nav(@pagy) %></noscript>
```
!!!

!!!warning Window Resizing
* If window size changes, `pagy_*nav_js` elements are automatically re-rendered.
* But, if the container width changes *without* a window resize, you need to explicitly re-render: 

```js
document.getElementById('my-pagy-nav-js').render();
```
!!!

!!!danger Overriding `*_js` helpers?
Not recommended: 

* Reliant on tightly coupled code.
* High fragility: likely.
!!!

## Troubleshooting / Demos

Try [any of the rails apps listed here.](https://github.com/stars/benkoshy/lists/rails-demo-apps-for-pagy)