class HomeController < ActionController::Base
layout "marketing"

  def index
    render template: "index"
  end
end