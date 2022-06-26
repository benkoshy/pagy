---
title: AJAX
category: Tools
image: null
order: 2
---

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
