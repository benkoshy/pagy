---
title: API Details
category: Tools
image: null
order: 3
---

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
