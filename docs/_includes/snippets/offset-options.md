`count_over: true`
: Use this option with `GROUP BY` collections to calculate the total number of results using `COUNT(*) OVER ()`.

`raise_range_error: true`
: Enable the `Pagy::RangeError` (which is otherwise rescued to an empty page by default).

`max_pages: 500`
: Restricts pagination to only `:max_pages`. _(Ignored by `Pagy::Calendar::*` unit instances)_

{{ include "snippets/paginator-options" }}