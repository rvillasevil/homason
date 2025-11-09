class HomeController < ApplicationController
  skip_before_action :set_current_user

  def index
    # The homepage is a static marketing view rendered from
    # app/views/home/index.html.erb. We don't need to perform
    # any controller work other than skipping authentication.
  end
end