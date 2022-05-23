# frozen_string_literal: true

module Covid19
  class HomeController < Chespirito::Controller
    def index
      response.status = 200
      response.headers['Content-Type'] = 'text/html'
      response.body = '<h1>Hello from COVID-19</h1>'
    end
  end
end
