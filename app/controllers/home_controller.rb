class HomeController < Chespirito::Controller
  def index
    response.status = 200
    response.headers['Content-Type'] = 'text/html'
    response.body = '<h1>Hello</h1>'
  end
end
