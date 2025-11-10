class HomeController < ApplicationController
  layout "marketing"

  def index
    render template: "home/index"
  end
end