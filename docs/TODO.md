---
order: 0
---
# TO DO
- [] Check the description that appears in the categories pages. 
  - Since retype uses the first few words of the first paragraph, we should reduce the exceeding first paragraphs so it will not look truncated in the category description 
- [] Refactor the description of `Pagy::Backend` 
- [] Refactor the description of `Pagy::I18n` (translation + localization) 
- [] Refactor of `index.md`: Rewrite the content... eventually moving part out or the README.
- [] Refactoring of How To: Try the panels or split in sup pages?
- [] Reorganize ALL the content with retype tabs, panels, columns, alert, warnings, notes etc.


- [] Ensure details re: request_path are added as per: [PR 403](https://github.com/ddnexus/pagy/pull/403)
- [] [Overflow](http://benkoshy.github.io/pagy/docs/extras/overflow/) - add some alert components with handy and short instructions to help people decide which mode they should choose.
- [] Add a choice of styles for Tailwind (i.e. bootstrap styling) + add in pictures of the styling.
- [] AJAX section probably needs updating - especially for new rails users. Stimulus JS + turbo streams are probably the new way of handling ajax rather than the old way of `.js.erb` templates.
- [] Add pictures of the various helpers to help people visualise what a helper looks like. e.g. `pagy_bulma_nav_js(pagy, ...)` - what does this look like again? Like this: show pic.
- Consider: updating [AJAX](../docs/api/javascript/ajax/) for the modern day tooling - nobody uses `.js.erb` anymore - Turbo Streams (and Stimulus JS) are what they use, and it serves much the same purpose.

# Page Status

**Retype Formatting:** Styling Components, Formatting

**Restructuring:** Substantive improvements: simplifying / shortening / presenting images etc.

Broken links: [!badge variant="danger" text="Needs Fixing!"]

Name   | Retype Formatting  | Restructuring
---    | ---
./index.md | [!badge variant="success" text="complete"]| [!badge variant="warning" text="TBD"]|
./api/backend.md | [!badge variant="success" text="complete"]| [!badge variant="warning" text="TBD"]|
./api/calendar.md | [!badge variant="success" text="complete"]| [!badge variant="warning" text="TBD"]|
./api/console.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./api/countless.md | [!badge variant="success" text="complete"]| [!badge variant="warning" text="TBD"]|
./api/frontend.md | [!badge variant="success" text="complete"]| [!badge variant="warning" text="TBD"]|
./api/i18n.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./api/javascript/ajax.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./api/javascript/combo-navs.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./api/javascript.md | [!badge variant="success" text="complete"] | [!badge variant="danger" text="Needs Fixing!"] |
./api/javascript/navs.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./api/javascript/setup.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./api/pagy.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/arel.md | [!badge variant="success" text="complete"]| [!badge variant="warning" text="TBD"]|
./extras/array.md | [!badge variant="success" text="complete"]| [!badge variant="warning" text="TBD"]|
./extras/bootstrap.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/bulma.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/calendar.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"]                |
./extras/countless.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/elasticsearch_rails.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/foundation.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/gearbox.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/headers.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/i18n.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/items.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/materialize.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/meilisearch.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/metadata.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/navs.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/overflow.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/searchkick.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/semantic.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/standalone.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/support.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/tailwind.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/trim.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./extras/uikit.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./how-to.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./migration-guide.md | [!badge variant="success" text="complete"] | [!badge variant="warning" text="TBD"] |
./requirements.md | [!badge variant="success" text="complete"]| [!badge variant="warning" text="TBD"]|
./TODO.md  | Delete when finished | Delete when finished |





Broken Links to Fix:

WARNING: [docs/extras/support.md:31] Consider revising URL "../navs" to a proper input path.

WARNING: [docs/extras/calendar.md:79] Page anchor "#pagy_calendar_periodcollection" was not found.
WARNING: [docs/extras/calendar.md:80] Page anchor "#pagy_calendar_filtercollection-from-to" was not found.
WARNING: [docs/extras/calendar.md:81] Page anchor "#pagy_calendarcollection-configuration" was not found.
WARNING: [docs/extras/countless.md:107] Page anchor "/docs/api/backend.md#pagy_get_itemscollection-pagy" was not found.







