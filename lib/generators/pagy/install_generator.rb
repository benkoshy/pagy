require 'rails/generators'
class Pagy
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root Pagy.root

      desc "Setup pagy.rb initializer"
      def copy_pagy_initializer
        copy_file "config/pagy.rb", rails_pagy_config_path
      end

      desc "add Pagy::Frontend to application_helper.rb"
      def install_frontend
        if File.exist?(application_helper_absolute_path)
          unless front_end_installed?
            say "\t#{set_color('Add', :green)}  `Pagy::Frontend` to application_helper.rb", :green
            inject_into_module "app/helpers/application_helper.rb", "ApplicationHelper", "\tinclude Pagy::Frontend\n"
          end
        else
          say "Could not find ApplicationHelper, could not add: `include Pagy::Frontend`", :red
        end
      end

      desc "add Pagy::Backend to application_controller.rb"
      def install_backend
        if File.exist?(application_controller_absolute_path)
          unless backend_installed?
            say "\t#{set_color('Add', :green)}  Pagy::Backend to app/controllers/application_controller.rb"
            inject_into_class "app/controllers/application_controller.rb", "ApplicationController", "\tinclude Pagy::Backend\n"
          end
        else
          say "Could not find ApplicationController to add `include Pagy::Backend`", :red
        end
      end

      class_option :extras, type: :array,
        required: false,
        desc: "Add pagy extras - choose from any frontend, backend or features extras: https://ddnexus.github.io/pagy/categories/extra/",
        banner: "bootstrap gearbox etc",
        enum: %w(bootstrap bulma foundation materialize semantic uikit navs arel array calendar countless elasticsearch_rails meilisearch metadata searchkick gearbox items overflow support trim i18n),
        default: [], lazy_default: []
      class_option :sequels, type: :boolean, default: false,
        desc: "Add this option if you are using the metadata extra and you want to use sequels",
        banner: "If sequels needed in frontend_helpers"
      def install_pagy_extras
        options[:extras].map(&:downcase).each do |extra|
          if pagy_extras.include?(extra)
            if extra == "metadata" && options[:sequels]
              # If we want sequels, then we need the frontend helpers BEFORE metadata is required
              install_extra("frontend_helpers")
              say "\t#{set_color('Installed', :green)} frontend_helpers. Usage: https://github.com/ddnexus/pagy/blob/master/lib/pagy/extras/frontend_helpers.rb"
            end

            install_extra(extra)

            say "\t#{set_color('Installed', :green)} #{extra}. Usage: https://ddnexus.github.io/pagy/docs/extras/#{extra}/"
          end
        end
      end

      class_option :template,
        type: :string,
        desc: "Add templates for the following styles: navs, bootstrap, bulma, foundation, uikit, to be copied into your app/views/pagy/ folder. Choose from erb, haml, or slim ",
        banner: " erb (or haml or slim)",
        enum: %w(erb slim haml),
        default: "", lazy_default: :nothing_specified
      def install_template
        # We might need to copy: bootstrap erb, or foundation slim
        # we need both the css_framework, and the template engine.
        # iterate through the css frameworks to install any relevant templates

        return if options[:template].empty?

        if options[:template] == :nothing_specified
          say "\tWarning: you have used the --template flag, but have not specified a value. No templates were installed.", :red
          return
        end

        template_engine = options[:template].downcase
        get_template_css_frameworks.each do |css_framework|
          if css_framework == "navs"
            copy_file "./templates/nav.html.#{template_engine}", "app/views/pagy/nav.html.#{template_engine}"
            say "\t#{set_color('Create', :green)} template: app/views/pagy/nav.html.#{template_engine}"
          else
            copy_file "./templates/#{css_framework}_nav.html.#{template_engine}", "app/views/pagy/#{css_framework}_nav.html.#{template_engine}"
            say "\t#{set_color('Create', :green)} template: app/views/pagy/#{css_framework}_nav.html.#{template_engine}"
          end
        end
      end

      private

      def install_extra(extra)
        # first we uncomment because typically, the pagy.rb file
        # will be copied over from a template in the gem.
        # if users change the pagy.rb template file (which is unlikely)
        # then we have to manually check whether the extra is installed.

        uncomment_lines(rails_pagy_config_path, /require 'pagy\/extras\/#{extra}'/)
        unless extra_installed?(extra)
          insert_into_file(rails_pagy_config_path, "\nrequire 'pagy\/extras\/#{extra}'")
        end
      end

      def get_template_css_frameworks
        templates_available = %w(bootstrap foundation uikit navs)
        css_frameworks =  templates_available & options[:extras].map(&:downcase)
        if css_frameworks.any?
          return css_frameworks
        else
          say "\t#{set_color('No template copied', :red)}. You must specify one of #{templates_available.join(", ")} with an --extras flag"
          return []
        end
      end

      def pagy_extras
      	# consider using constants:
        front_end_extras = %w(bootstrap bulma foundation materialize semantic uikit navs) # navs is a special case of styling.
        backend_extras = %w(arel array calendar countless elasticsearch_rails meilisearch metadata searchkick)
        features_extras = %w(gearbox items overflow support trim i18n)

        return front_end_extras + backend_extras + features_extras
      end

      def extra_installed?(extra)
        File.readlines(rails_pagy_config_absolute_path)
        .grep(/^s*require 'pagy\/extras\/#{extra}'/)
        .any?
      end

      def front_end_installed?
        File.readlines(application_helper_absolute_path)
        .grep(/^\s*include Pagy::Frontend/)
        .any?
      end

      def backend_installed?
        File.readlines(application_controller_absolute_path)
        .grep(/^\s*include Pagy::Backend/)
        .any?
      end

      ### Paths to files in the targeted Rails app      
      def rails_pagy_config_path # relative path
        "config/initializers/pagy.rb"
      end

      def rails_pagy_config_absolute_path
        rails_file_absolute_path(rails_pagy_config_path)
      end

      def application_helper_absolute_path
        rails_file_absolute_path("app/helpers/application_helper.rb")
      end

      def application_controller_absolute_path
        rails_file_absolute_path("app/controllers/application_controller.rb")
      end

      def rails_file_absolute_path(relative_path)
        File.expand_path(relative_path, destination_root)
      end
    end
  end
end
