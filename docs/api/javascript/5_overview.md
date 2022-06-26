---
title: Overview
category: Tools
image: null
order: 5
---

### What's Available?

Choose from the following JS helpers / CSS framework flavours:

1. pagy*_nav_js
2. pagy*_combo_nav_js
3. pagy_items_selector_js

+++ pagy*_nav_js

![bootstrap_nav_js](../../assets/images/bootstrap_nav_js-g.png)

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

![bootstrap_combo_nav_js](../../assets/images/bootstrap_combo_nav_js-g.png)

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

