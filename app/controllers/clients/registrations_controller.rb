module Clients
  class RegistrationsController < ApplicationController
    layout "marketing"

    def new
      @form_data = {
        name: "",
        email: "",
        phone: "",
        address: "",
        role: "customer"
      }
      @form_errors = []
    end
  end
end