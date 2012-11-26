module Corkboard
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Installs Corkboard."
  
      def install_initializer
        template "initializer.rb", "config/initializers/corkboard.rb"
      end
  
      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
