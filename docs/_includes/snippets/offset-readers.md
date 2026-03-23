`offset`
: The OFFSET used in the SQL query

`count`
: The collection count

`from`
: The position in the collection of the first item on the page. _(Different Pagy classes may use different value types for it)._

`to`
: The position in the collection of the last item on the page. _(Different Pagy classes may use different value types for it)._

`last`
: The last page.

`pages`
: The number of pages.

`max_pages: 500`
: Restricts pagination to only `:max_pages`. _(Ignored by `Pagy::Calendar::*` unit instances)_

`previous`
: The previous page

{{ include "paginator-readers"