class HomeController < ActionController::Base
layout "marketing"

  def index
    render template: "home/index"
  end
end