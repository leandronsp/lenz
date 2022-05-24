# frozen_string_literal: true

require 'chespirito'

Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].sort.each { |file| require file }

module Covid19
  def self.application
    Chespirito::App.configure do |app|
      app.register_route('GET', '/covid19/:iso_code', [ReportsController, :index])
    end
  end
end
