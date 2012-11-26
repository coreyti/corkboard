Jasminerice::Runner.capybara_driver = (ENV['CAPYBARA_JS'] || :webkit).intern

Rails.application.config.assets.paths << Corkboard::Engine.root.join('spec/javascripts')
Rails.application.config.assets.paths << Corkboard::Engine.root.join('spec/stylesheets')
ActionController::Base.prepend_view_path Corkboard::Engine.root
