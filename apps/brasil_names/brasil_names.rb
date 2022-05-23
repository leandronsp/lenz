# frozen_string_literal: true

require 'chespirito'

Dir[File.dirname(__FILE__) + '/app/**/*.rb'].sort.each { |file| require file }

module BrasilNames
  def self.application
    Chespirito::App.configure do |app|
      app.register_route('GET', '/', [HomeController, :index])
    end
  end
end
