`count_over: true`
: Use this option with `GROUP BY` collections to calculate the total number of results using `COUNT(*) OVER ()`.

`raise_range_error: true`
: Enable the `Pagy::RangeError` (which is otherwise rescued to an empty page by default).

{{ include "snippets/paginator-options" }}