require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
#require "active_record/railtie"
require "action_controller/railtie"
#require "action_mailer/railtie"
#require "active_resource/railtie"
require "sprockets/railtie"
#require "rails/test_unit/railtie"

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module BudgetApp
  class Application < Rails::Application
    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
    config.assets.precompile += %w( modernizr.js print.css )

    config.assets.initialize_on_precompile = false

    config.google_analytics = false
  end
end
