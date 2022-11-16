class InsuranceCompaniesController < ApplicationController
  before_action :check_admin, only: %i[index show new create edit update activate deactivate]

  def index
    @insurance_companies = InsuranceCompany.all
  end

  def show
    @insurance_company = InsuranceCompany.find(params[:id])
  end

  def new
    @insurance_company = InsuranceCompany.new
  end

  def edit
    @insurance_company = InsuranceCompany.find(params[:id])
  end

  def create
    @insurance_company = InsuranceCompany.new(insurance_company_params)
    if @insurance_company.save
      flash[:notice] = t('.success')
      redirect_to @insurance_company
    else
      flash.now[:alert] = t('.failure')
      render 'new'
    end
  end

  def update
    @insurance_company = InsuranceCompany.find(params[:id])
    if @insurance_company.update(insurance_company_params)
      flash[:notice] = t('.update_success')
      redirect_to @insurance_company
    else
      flash.now[:alert] = t('.update_failure')
      render 'edit'
    end
  end

  def activate
    @insurance_company = InsuranceCompany.find(params[:id])
    @insurance_company.active!
    redirect_to @insurance_company, notice: t('.success')
  end

  def deactivate
    @insurance_company = InsuranceCompany.find(params[:id])
    @insurance_company.inactive!
    redirect_to @insurance_company, notice: t('.success')
  end

  private

  def insurance_company_params
    params.require(:insurance_company).permit(:name, :email_domain, :registration_number, :logo)
  end
end
