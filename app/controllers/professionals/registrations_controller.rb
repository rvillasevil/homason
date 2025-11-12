module Professionals
  class RegistrationsController < ApplicationController
    layout "marketing"

    def new
      @form_data = {
        name: "",
        email: "",
        phone: "",
        address: "",
        role: "professional"
      }
      @form_errors = []
    end
  end
end