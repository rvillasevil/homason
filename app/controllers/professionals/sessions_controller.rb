module Professionals
  class SessionsController < ApplicationController
    layout "marketing"

    def new
      @form_data = { email: "", role: "professional" }
      @form_errors = []
    end
  end
end