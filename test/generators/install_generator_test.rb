# To run these tests:
# rake test_install_generator
# To invoke tests:
# ./bin/rails g pagy:install --extras bootstrap etc --sequels --template erb

require_relative '../test_helper'
require "generators/pagy/install_generator"

class PagyInstallGeneratorTest < Rails::Generators::TestCase
  tests Pagy::Generators::InstallGenerator

  destination File.expand_path("#{__dir__}/rails_app") # we make make this a temp file?
  setup :prepare_destination
  teardown :restore_destination

  def prepare_destination
    # all files are destroyed after a test
    # we must create a backup of files
    # and restore them after the tests are finished.
    # Some files such as application_controller and application_helper
    # Must be existing prior to the tests running. We then edit those
    # files and restore them to the state before the tests ran.

    views_path = File.expand_path("./app/views/pagy/*", test_rails_app_path)
    FileUtils.rm_rf Dir.glob("#{views_path}")

    backup_file("./app/helpers/application_helper.rb")
    backup_file("./app/controllers/application_controller.rb")
    delete_rails_app_pagy_config_file
  end

  def restore_destination
    restore_file("./app/helpers/application_helper.rb")
    restore_file("./app/controllers/application_controller.rb")
    delete_rails_app_pagy_config_file

    views_path = File.expand_path("./app/views/pagy/*", test_rails_app_path)
    FileUtils.rm_rf Dir.glob("#{views_path}")
  end


  def test_run_generator
    delete_rails_app_pagy_config_file
    run_generator ["pagy:install --extras bootstrap"]
    assert_file "./config/initializers/pagy.rb", <<-RUBY.strip_heredoc
    # frozen_string_literal: true

    # Pagy initializer file (6.0.4)
    # Customize only what you really need and notice that the core Pagy works also without any of the following lines.
    # Should you just cherry pick part of this file, please maintain the require-order of the extras


    # Pagy DEFAULT Variables
    # See https://ddnexus.github.io/pagy/docs/api/pagy#variables
    # All the Pagy::DEFAULT are set for all the Pagy instances but can be overridden per instance by just passing them to
    # Pagy.new|Pagy::Countless.new|Pagy::Calendar::*.new or any of the #pagy* controller methods


    # Instance variables
    # See https://ddnexus.github.io/pagy/docs/api/pagy#instance-variables
    # Pagy::DEFAULT[:page]   = 1                                  # default
    # Pagy::DEFAULT[:items]  = 20                                 # default
    # Pagy::DEFAULT[:outset] = 0                                  # default


    # Other Variables
    # See https://ddnexus.github.io/pagy/docs/api/pagy#other-variables
    # Pagy::DEFAULT[:size]       = [1,4,4,1]                       # default
    # Pagy::DEFAULT[:page_param] = :page                           # default
    # The :params can be also set as a lambda e.g ->(params){ params.exclude('useless').merge!('custom' => 'useful') }
    # Pagy::DEFAULT[:params]     = {}                              # default
    # Pagy::DEFAULT[:fragment]   = '#fragment'                     # example
    # Pagy::DEFAULT[:link_extra] = 'data-remote="true"'            # example
    # Pagy::DEFAULT[:i18n_key]   = 'pagy.item_name'                # default
    # Pagy::DEFAULT[:cycle]      = true                            # example
    # Pagy::DEFAULT[:request_path] = "/foo"                        # example


    # Extras
    # See https://ddnexus.github.io/pagy/categories/extra


    # Backend Extras

    # Arel extra: For better performance utilizing grouped ActiveRecord collections:
    # See: https://ddnexus.github.io/pagy/docs/extras/arel
    # require 'pagy/extras/arel'

    # Array extra: Paginate arrays efficiently, avoiding expensive array-wrapping and without overriding
    # See https://ddnexus.github.io/pagy/docs/extras/array
    # require 'pagy/extras/array'

    # Calendar extra: Add pagination filtering by calendar time unit (year, quarter, month, week, day)
    # See https://ddnexus.github.io/pagy/docs/extras/calendar
    # require 'pagy/extras/calendar'
    # Default for each unit
    # Pagy::Calendar::Year::DEFAULT[:order]     = :asc        # Time direction of pagination
    # Pagy::Calendar::Year::DEFAULT[:format]    = '%Y'        # strftime format
    #
    # Pagy::Calendar::Quarter::DEFAULT[:order]  = :asc        # Time direction of pagination
    # Pagy::Calendar::Quarter::DEFAULT[:format] = '%Y-Q%q'    # strftime format
    #
    # Pagy::Calendar::Month::DEFAULT[:order]    = :asc        # Time direction of pagination
    # Pagy::Calendar::Month::DEFAULT[:format]   = '%Y-%m'     # strftime format
    #
    # Pagy::Calendar::Week::DEFAULT[:order]     = :asc        # Time direction of pagination
    # Pagy::Calendar::Week::DEFAULT[:format]    = '%Y-%W'     # strftime format
    #
    # Pagy::Calendar::Day::DEFAULT[:order]      = :asc        # Time direction of pagination
    # Pagy::Calendar::Day::DEFAULT[:format]     = '%Y-%m-%d'  # strftime format
    #
    # Uncomment the following lines, if you need calendar localization without using the I18n extra
    # module LocalizePagyCalendar
    #   def localize(time, opts)
    #     ::I18n.l(time, **opts)
    #   end
    # end
    # Pagy::Calendar.prepend LocalizePagyCalendar

    # Countless extra: Paginate without any count, saving one query per rendering
    # See https://ddnexus.github.io/pagy/docs/extras/countless
    # require 'pagy/extras/countless'
    # Pagy::DEFAULT[:countless_minimal] = false   # default (eager loading)

    # Elasticsearch Rails extra: Paginate `ElasticsearchRails::Results` objects
    # See https://ddnexus.github.io/pagy/docs/extras/elasticsearch_rails
    # Default :pagy_search method: change only if you use also
    # the searchkick or meilisearch extra that defines the same
    # Pagy::DEFAULT[:elasticsearch_rails_pagy_search] = :pagy_search
    # Default original :search method called internally to do the actual search
    # Pagy::DEFAULT[:elasticsearch_rails_search] = :search
    # require 'pagy/extras/elasticsearch_rails'

    # Headers extra: http response headers (and other helpers) useful for API pagination
    # See http://ddnexus.github.io/pagy/extras/headers
    # require 'pagy/extras/headers'
    # Pagy::DEFAULT[:headers] = { page: 'Current-Page',
    #                            items: 'Page-Items',
    #                            count: 'Total-Count',
    #                            pages: 'Total-Pages' }     # default

    # Meilisearch extra: Paginate `Meilisearch` result objects
    # See https://ddnexus.github.io/pagy/docs/extras/meilisearch
    # Default :pagy_search method: change only if you use also
    # the elasticsearch_rails or searchkick extra that define the same method
    # Pagy::DEFAULT[:meilisearch_pagy_search] = :pagy_search
    # Default original :search method called internally to do the actual search
    # Pagy::DEFAULT[:meilisearch_search] = :ms_search
    # require 'pagy/extras/meilisearch'

    # Metadata extra: Provides the pagination metadata to Javascript frameworks like Vue.js, react.js, etc.
    # See https://ddnexus.github.io/pagy/docs/extras/metadata
    # you must require the frontend helpers internal extra (BEFORE the metadata extra) ONLY if you need also the :sequels
    # require 'pagy/extras/frontend_helpers'
    # require 'pagy/extras/metadata'
    # For performance reasons, you should explicitly set ONLY the metadata you use in the frontend
    # Pagy::DEFAULT[:metadata] = %i[scaffold_url page prev next last]   # example

    # Searchkick extra: Paginate `Searchkick::Results` objects
    # See https://ddnexus.github.io/pagy/docs/extras/searchkick
    # Default :pagy_search method: change only if you use also
    # the elasticsearch_rails or meilisearch extra that defines the same
    # DEFAULT[:searchkick_pagy_search] = :pagy_search
    # Default original :search method called internally to do the actual search
    # Pagy::DEFAULT[:searchkick_search] = :search
    # require 'pagy/extras/searchkick'
    # uncomment if you are going to use Searchkick.pagy_search
    # Searchkick.extend Pagy::Searchkick


    # Frontend Extras

    # Bootstrap extra: Add nav, nav_js and combo_nav_js helpers and templates for Bootstrap pagination
    # See https://ddnexus.github.io/pagy/docs/extras/bootstrap
    # require 'pagy/extras/bootstrap'

    # Bulma extra: Add nav, nav_js and combo_nav_js helpers and templates for Bulma pagination
    # See https://ddnexus.github.io/pagy/docs/extras/bulma
    # require 'pagy/extras/bulma'

    # Foundation extra: Add nav, nav_js and combo_nav_js helpers and templates for Foundation pagination
    # See https://ddnexus.github.io/pagy/docs/extras/foundation
    # require 'pagy/extras/foundation'

    # Materialize extra: Add nav, nav_js and combo_nav_js helpers for Materialize pagination
    # See https://ddnexus.github.io/pagy/docs/extras/materialize
    # require 'pagy/extras/materialize'

    # Navs extra: Add nav_js and combo_nav_js javascript helpers
    # Notice: the other frontend extras add their own framework-styled versions,
    # so require this extra only if you need the unstyled version
    # See https://ddnexus.github.io/pagy/docs/extras/navs
    # require 'pagy/extras/navs'

    # Semantic extra: Add nav, nav_js and combo_nav_js helpers for Semantic UI pagination
    # See https://ddnexus.github.io/pagy/docs/extras/semantic
    # require 'pagy/extras/semantic'

    # UIkit extra: Add nav helper and templates for UIkit pagination
    # See https://ddnexus.github.io/pagy/docs/extras/uikit
    # require 'pagy/extras/uikit'

    # Multi size var used by the *_nav_js helpers
    # See https://ddnexus.github.io/pagy/docs/extras/navs#steps
    # Pagy::DEFAULT[:steps] = { 0 => [2,3,3,2], 540 => [3,5,5,3], 720 => [5,7,7,5] }   # example


    # Feature Extras

    # Gearbox extra: Automatically change the number of items per page depending on the page number
    # See https://ddnexus.github.io/pagy/docs/extras/gearbox
    # require 'pagy/extras/gearbox'
    # set to false only if you want to make :gearbox_extra an opt-in variable
    # Pagy::DEFAULT[:gearbox_extra] = false               # default true
    # Pagy::DEFAULT[:gearbox_items] = [15, 30, 60, 100]   # default

    # Items extra: Allow the client to request a custom number of items per page with an optional selector UI
    # See https://ddnexus.github.io/pagy/docs/extras/items
    # require 'pagy/extras/items'
    # set to false only if you want to make :items_extra an opt-in variable
    # Pagy::DEFAULT[:items_extra] = false    # default true
    # Pagy::DEFAULT[:items_param] = :items   # default
    # Pagy::DEFAULT[:max_items]   = 100      # default

    # Overflow extra: Allow for easy handling of overflowing pages
    # See https://ddnexus.github.io/pagy/docs/extras/overflow
    # require 'pagy/extras/overflow'
    # Pagy::DEFAULT[:overflow] = :empty_page    # default  (other options: :last_page and :exception)

    # Support extra: Extra support for features like: incremental, infinite, auto-scroll pagination
    # See https://ddnexus.github.io/pagy/docs/extras/support
    # require 'pagy/extras/support'

    # Trim extra: Remove the page=1 param from links
    # See https://ddnexus.github.io/pagy/docs/extras/trim
    # require 'pagy/extras/trim'
    # set to false only if you want to make :trim_extra an opt-in variable
    # Pagy::DEFAULT[:trim_extra] = false # default true

    # Standalone extra: Use pagy in non Rack environment/gem
    # See https://ddnexus.github.io/pagy/docs/extras/standalone
    # require 'pagy/extras/standalone'
    # Pagy::DEFAULT[:url] = 'http://www.example.com/subdir'  # optional default


    # Rails
    # Enable the .js file required by the helpers that use javascript
    # (pagy*_nav_js, pagy*_combo_nav_js, and pagy_items_selector_js)
    # See https://ddnexus.github.io/pagy/docs/api/javascript

    # With the asset pipeline
    # Sprockets need to look into the pagy javascripts dir, so add it to the assets paths
    # Rails.application.config.assets.paths << Pagy.root.join('javascripts')

    # I18n

    # Pagy internal I18n: ~18x faster using ~10x less memory than the i18n gem
    # See https://ddnexus.github.io/pagy/docs/api/i18n
    # Notice: No need to configure anything in this section if your app uses only "en"
    # or if you use the i18n extra below
    #
    # Examples:
    # load the "de" built-in locale:
    # Pagy::I18n.load(locale: 'de')
    #
    # load the "de" locale defined in the custom file at :filepath:
    # Pagy::I18n.load(locale: 'de', filepath: 'path/to/pagy-de.yml')
    #
    # load the "de", "en" and "es" built-in locales:
    # (the first passed :locale will be used also as the default_locale)
    # Pagy::I18n.load({ locale: 'de' },
    #                 { locale: 'en' },
    #                 { locale: 'es' })
    #
    # load the "en" built-in locale, a custom "es" locale,
    # and a totally custom locale complete with a custom :pluralize proc:
    # (the first passed :locale will be used also as the default_locale)
    # Pagy::I18n.load({ locale: 'en' },
    #                 { locale: 'es', filepath: 'path/to/pagy-es.yml' },
    #                 { locale: 'xyz',  # not built-in
    #                   filepath: 'path/to/pagy-xyz.yml',
    #                   pluralize: lambda{ |count| ... } )


    # I18n extra: uses the standard i18n gem which is ~18x slower using ~10x more memory
    # than the default pagy internal i18n (see above)
    # See https://ddnexus.github.io/pagy/docs/extras/i18n
    # require 'pagy/extras/i18n'

    # Default i18n key
    # Pagy::DEFAULT[:i18n_key] = 'pagy.item_name'   # default


    # When you are done setting your own default freeze it, so it will not get changed accidentally
    Pagy::DEFAULT.freeze
    RUBY
  end

  ## Test extras

  def test_inject_backend
    run_generator %w(pagy:install)
    assert_file './app/controllers/application_controller.rb', /include Pagy::Backend/
  end

  def test_inject_frontend
    run_generator %w(pagy:install)
    assert_file './app/helpers/application_helper.rb', /include Pagy::Frontend/
  end

  def test_add_css_bootstrap
    run_generator %w(pagy:install --extras bootstrap)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/bootstrap'/
  end

  def test_add_css_bulma
    run_generator %w(pagy:install --extras bulma)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/bulma'/
  end

  def test_add_css_foundation
    run_generator %w(pagy:install --extras foundation)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/foundation'/
  end

  def test_add_css_materialize
    run_generator %w(pagy:install --extras materialize)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/materialize'/
  end

  def test_add_css_semantic
    run_generator %w(pagy:install --extras semantic)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/semantic'/
  end

  def test_add_css_uikit
    run_generator %w(pagy:install --extras uikit)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/uikit'/
  end

  def test_add_navs
    run_generator %w(pagy:install --extras navs)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/navs'/
  end

  ## Backend tests

  def test_add_arel
    run_generator %w(pagy:install --extras arel)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/arel'/
  end

  def test_add_array
    run_generator %w(pagy:install --extras array)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/array'/
  end

  def test_add_calendar
    run_generator %w(pagy:install --extras calendar)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/calendar'/
  end

  def test_add_countless
    run_generator %w(pagy:install --extras countless)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/countless'/
  end

  def test_add_elasticsearch_rails
    run_generator %w(pagy:install --extras elasticsearch_rails)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/elasticsearch_rails'/
  end

  def test_add_meilisearch
    run_generator %w(pagy:install --extras meilisearch)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/meilisearch'/
  end

  def test_add_metadata
    run_generator %w(pagy:install --extras metadata)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/metadata'/
    assert extra_installed?("metadata")
    refute extra_installed?("frontend_helpers")
  end

  def test_add_metadata_with_sequels
    run_generator %w(pagy:install --sequels --extras metadata)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/frontend_helpers'/
    assert extra_installed?("frontend_helpers")
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/metadata'/
    assert extra_installed?("metadata")
  end

  def test_add_searchkick
    run_generator %w(pagy:install --extras searchkick)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/searchkick'/
  end

  ## features extras
  def test_add_gearbox
    run_generator %w(pagy:install --extras gearbox)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/gearbox'/
  end

  def test_add_items
    run_generator %w(pagy:install --extras items)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/items'/
  end

  def test_add_overflow
    run_generator %w(pagy:install --extras overflow)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/overflow'/
  end

  def test_add_support
    run_generator %w(pagy:install --extras support)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/support'/
  end

  def test_add_trim
    run_generator %w(pagy:install --extras trim)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/trim'/
  end

  def test_add_i18n
    run_generator %w(pagy:install --extras i18n)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/i18n'/
  end

  ## Template Tests

  def test_bootstrap_erb_template
    run_generator %w(pagy:install --extras bootstrap --template erb)
    assert_file './app/views/pagy/bootstrap_nav.html.erb'
  end

  def test_bootstrap_slim_template
    run_generator %w(pagy:install --extras bootstrap --template slim)
    assert_file './app/views/pagy/bootstrap_nav.html.slim'
  end

  def test_bootstrap_haml_template
    run_generator %w(pagy:install --extras bootstrap --template haml)
    assert_file './app/views/pagy/bootstrap_nav.html.haml'
  end

  def test_uikit_erb_template
    run_generator %w(pagy:install --extras uikit --template erb)
    assert_file './app/views/pagy/uikit_nav.html.erb'
  end

  def test_uikit_slim_template
    run_generator %w(pagy:install --extras uikit --template slim)
    assert_file './app/views/pagy/uikit_nav.html.slim'
  end

  def test_uikit_haml_template
    run_generator %w(pagy:install --extras uikit --template haml)
    assert_file './app/views/pagy/uikit_nav.html.haml'
  end

  def test_foundation_erb_template
    run_generator %w(pagy:install --extras foundation --template erb)
    assert_file './app/views/pagy/foundation_nav.html.erb'
  end

  def test_foundation_slim_template
    run_generator %w(pagy:install --extras foundation --template slim)
    assert_file './app/views/pagy/foundation_nav.html.slim'
  end

  def test_foundation_haml_template
    run_generator %w(pagy:install --extras foundation --template haml)
    assert_file './app/views/pagy/foundation_nav.html.haml'
  end

  def test_navs_erb_template
    run_generator %w(pagy:install --extras navs --template erb)
    assert_file './app/views/pagy/nav.html.erb'
  end

  def test_navs_slim_template
    run_generator %w(pagy:install --extras navs --template slim)
    assert_file './app/views/pagy/nav.html.slim'
  end

  def test_navs_haml_template
    run_generator %w(pagy:install --extras navs --template haml)
    assert_file './app/views/pagy/nav.html.haml'
  end

  def test_template_without_template_engine_specified
    run_generator %w(pagy:install --template)
    assert Dir.glob(absolute_path_of_rails_file('./app/views/pagy/*.html.*')).empty?
  end

  def test_template_without_css_specified
    run_generator %w(pagy:install --template erb)
    assert Dir.glob(absolute_path_of_rails_file('./app/views/pagy/*.html.*')).empty?
  end

  def test_template_with_css_specified
    run_generator %w(pagy:install --extras bootstrap --template erb)
    refute Dir.glob(absolute_path_of_rails_file('./app/views/pagy/*.html.*')).empty?
  end

  ## Test multiple options
  def test_multiple_extras_bootstrap_countless_gearbox
    run_generator %w(pagy:install --extras bootstrap countless gearbox)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/bootstrap'/
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/countless'/
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/gearbox'/
  end

  def test_multiple_extras_bootstrap_countless_gearbox_with_slim_template
    run_generator %w(pagy:install --extras bootstrap countless gearbox --template slim)
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/bootstrap'/
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/countless'/
    assert_file './config/initializers/pagy.rb', /^require 'pagy\/extras\/gearbox'/
    refute Dir.glob(absolute_path_of_rails_file('./app/views/pagy/*.html.slim')).empty?
  end

  private

  def backup_file(relative_path)
    absolute_path = File.expand_path(relative_path, self.destination_root)
    copy_file absolute_path, "#{absolute_path}.bak"
  end

  def restore_file(relative_path)
    absolute_path = File.expand_path(relative_path, self.destination_root)
    copy_file ("#{absolute_path}.bak"), absolute_path
    File.delete("#{absolute_path}.bak")
  end

  def delete_rails_app_pagy_config_file
    File.delete(rails_config_file_absolute_path) if File.exist?(rails_config_file_absolute_path)
  end

  def absolute_path_of_rails_file(relative_path_from_rails_root)
    File.expand_path(relative_path_from_rails_root, self.destination_root)
  end

  def test_rails_app_path
    File.expand_path("#{__dir__}/rails_app")
  end

  def rails_config_file_absolute_path
    absolute_path_of_rails_file("./config/initializers/pagy.rb")
  end

  def extra_installed?(extra)
    File.readlines(rails_config_file_absolute_path)
    .grep(/^s*require 'pagy\/extras\/#{extra}'/)
    .any?
  end

end
