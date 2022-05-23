# frozen_string_literal: true

require 'chespirito'

Dir['./app/**/*.rb'].sort.each { |file| require file }

module Lenz
  def self.application
    Chespirito::App.configure do |app|
      app.register_route('GET', '/', [HomeController, :index])
    end
  end
end
