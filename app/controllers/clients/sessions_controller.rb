module Clients
  class SessionsController < ApplicationController
    layout "marketing"

    def new
      @form_data = { email: "", role: "customer" }
      @form_errors = []
    end
  end
end