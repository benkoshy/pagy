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
