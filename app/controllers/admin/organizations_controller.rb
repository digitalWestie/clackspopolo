class Admin::OrganizationsController < Admin::AdminController

  def index
    @organizations = Popolo::Organization.all
  end

  def new
    @organization = Popolo::Organization.new
  end

  def show
    @organization = Popolo::Organization.find(params[:id])
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
    Rails.logger.info @organization.contact_details.count
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
    handle_date_params(params[:organization], "founding_date")
    handle_date_params(params[:organization], "dissolution_date")
    params.require(:organization).permit(:name, :classification, :abstract, :founding_date, 
      :dissolution_date, :description, :image,
      sources_attributes: [:url, :note, :_destroy, :id], 
      links_attributes: [:url, :note, :_destroy, :id],
      contact_details_attributes: [:label, :type, :value, :note, :_destroy, :id])
  end

end
