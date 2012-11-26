module Support
  module ConfigHelpers
    def with_config(method, value)
      Corkboard.send(method, value)
      yield
    ensure
      # NOTE: capturing and resetting-to the original (above) resulted in
      # intermittent failures. Using defaults here is more stable, but
      # will require maintenance (in the event that the defaults change).
      Corkboard.send(method, send(:"defaults_for_#{method}"))
    end

    def defaults_for_authentication
      { :admin => :disallow!, :board => nil }
    end

    def defaults_for_presentation
      {
        :title       => 'Corkboard',
        :description => 'Corkboard',
        :framework   => :bootstrap,
        :weights     => { :s => 10, :m => 3, :l => 1 }
      }
    end
  end
end
