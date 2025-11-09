class HomeController < ActionController::Base
  layout false

  def index
    render template: "index"
  end
end