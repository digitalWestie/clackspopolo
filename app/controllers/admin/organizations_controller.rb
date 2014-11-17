class Admin::OrganizationsController < ApplicationController

  def index
    @organizations = Popolo::Organization.all
    respond_to do |format|
      format.html
    end
  end

  def new
    @organization = Popolo::Organization.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @organization = Popolo::Organization.new(organization_params)
    respond_to do |format|
      if @organization.save
        format.html do
          redirect_to admin_organizations_url, notice: 'Organisation was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @organization = Popolo::Organization.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def update
    @organization = Popolo::Organization.find(params[:id])
    respond_to do |format|
      if @organization.update_attributes(organization_params)
        format.html do
          redirect_to admin_organizations_path,  notice: 'Organisation was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    organization = Popolo::Organization.find(params[:id])
    organization.destroy
    respond_to do |format|
      format.html { redirect_to admin_organizations_path }
    end
  end

  private

  def organization_params
    founding_date_str = [params[:organization].delete("founding_date(1i)")]
    founding_date_str << params[:organization].delete("founding_date(2i)")
    founding_date_str << params[:organization].delete("founding_date(3i)")
    founding_date_str = founding_date_str.join('-')
    params[:organization].merge!("founding_date" => founding_date_str) unless founding_date_str.eql?('--')

    dissolution_date_str = [params[:organization].delete("dissolution_date(1i)")]
    dissolution_date_str << params[:organization].delete("dissolution_date(2i)")
    dissolution_date_str << params[:organization].delete("dissolution_date(3i)")
    dissolution_date_str = dissolution_date_str.join('-')

    params[:organization].merge!("dissolution_date" => dissolution_date_str) unless dissolution_date_str.eql?('--')
  end

end
