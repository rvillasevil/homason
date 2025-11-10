class LeadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lead, only: [:show, :update, :destroy]
  before_action :authorize_lead!, only: [:show, :update, :destroy]

  def index
    leads = policy_scope
    leads = leads.where(status: params[:status]) if params[:status].present?
    leads = leads.includes(:customer, professional_profile: :user).order(created_at: :desc)

    render json: leads.map { |lead| serialize_lead(lead) }
  end

  def show
    render json: serialize_lead(@lead)
  end

  def create
    lead = Lead.new(lead_params)
    assign_context(lead)

    if lead.save
      render json: serialize_lead(lead), status: :created
    else
      render json: { errors: lead.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @lead.assign_attributes(lead_params)
    assign_context(@lead)

    if @lead.save
      render json: serialize_lead(@lead)
    else
      render json: { errors: @lead.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @lead.destroy
    head :no_content
  end

  private

  def policy_scope
    case current_user.role
    when "admin"
      Lead.all
    when "professional"
      if current_user.professional_profile_id.present?
        Lead.where(professional_profile_id: current_user.professional_profile_id)
      else
        Lead.none
      end
    else
      Lead.where(customer_id: current_user.id)
    end
  end

  def assign_context(lead)
    if current_user.customer?
      lead.customer ||= current_user
    elsif current_user.professional? && current_user.professional_profile.present?
      lead.professional_profile ||= current_user.professional_profile
    end
  end

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def authorize_lead!
    return if current_user.admin?
    return if @lead.customer_id.present? && @lead.customer_id == current_user.id
    return if @lead.professional_profile&.user_id == current_user.id

    render json: { error: "Forbidden" }, status: :forbidden
  end

  def lead_params
    params.require(:lead).permit(:name, :email, :phone, :status, :source, :notes, :customer_id, :professional_profile_id, :follow_up_at)
  end

  def serialize_lead(lead)
    lead.as_json.merge(
      customer: lead.customer&.slice(:id, :name, :email),
      professional: lead.professional_profile&.user&.slice(:id, :name, :email),
      professional_profile_id: lead.professional_profile_id
    )
  end
end