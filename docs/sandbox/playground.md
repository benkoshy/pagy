---
label: Playground
order: 100
icon: play
---

#

## :icon-play-24:&nbsp;&nbsp;Playground

---

You can showcase, clone, and develop a few Pagy apps without needing to set anything up on your side!

```sh
$ pagy --help
```

### Apps

We have a few single-file apps ready to run in your browser for various purposes. Most of them are used to run the [E2e Test](https://github.com/ddnexus/pagy/blob/master/.github/workflows/e2e-test.yml) workflow.

!!!success

Bundler automatically installs the required gems during the first run.

!!!

=== Repro App _(interaction example)_ {#repro}

You can use this app as a starting point to try Pagy or reproduce issues to get support or file bug reports.

>>> Clone the `repro` app

```sh
pagy clone repro
```

You should find the `./repro.ru` cloned app file in the current directory. Feel free to rename or move it as you wish.

>>> Develop it

This command runs your `rackup` app with a `puma` server.

```sh
pagy path/to/your-repro.ru
```

>>> Open a browser and navigate to http://127.0.0.1:8000

>>>

===

Rails App {#rails}
: Use it to reproduce **Rails-related** Pagy issues

  ```sh
  pagy clone rails
  pagy ./rails.ru
  ```

Demo App {#demo}
: The interactive showcase for all the pagy helpers and CSS styles

  ```sh
  pagy demo
  ```

Calendar App {#calendar}
: This is the interactive showcase and reproduction tool for the `:calendar` paginator

  ```sh
  pagy calendar
  ```

Keyset Apps  {#keysets}
: These are the interactive showcase/repro for the `:keyset` paginator with `ActiveRecord` or `Sequel` sets:

  ```sh
  pagy | grep key
    keynav                     Showcase the Keynav pagination (ActiveRecord example)
    keyset                     Showcase the Keyset pagination (ActiveRecord example)
    keyset_sequel              Showcase the Keyset pagination (Sequel example)

  pagy keynav
  pagy keyset
  pagy keyset_sequel
  ```

### Troubleshooting

==- Bundler inline

All the pagy apps use [bundler/inline](https://bundler.io/guides/bundler_in_a_single_file_ruby_script.html).

Depending on your environment, you might get this message for some gem:

```txt
You have already activated GEMNAME v1, but your Gemfile requires GEMNAME v2.
Prepending `bundle exec` to your command may solve this.
```

If `bundle exec` doesn't solve it, then try `bundle update` and `gem cleanup`. If you encounter another error after that:

```txt
... `find_spec_for_exe': can't find gem GEMNAME (>= 0.x) with executable EXEC (Gem::GemNotFoundException)
```

then `gem pristine GEMNAME` should solve the problem.

===
