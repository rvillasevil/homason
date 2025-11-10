class HomeController < ApplicationController
  layout "marketing"

  def index
    render "home/index"
  end
end