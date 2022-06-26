---
title: Installation Instructions
category: Tools
image: null
order: 4
---

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
