class Admin::MembershipsController < Admin::AdminController

  before_filter :set_organization

  def new
    @membership = @organization.memberships.build
    @posts = @organization.posts.pluck(:label, :id)
    @people = Popolo::Person.all.collect { |p| [p.to_s, p.id] }
  end

  def create
    @membership = @organization.memberships.build(membership_params)
    if @membership.save
      redirect_to admin_organization_path(@organization), notice: "Membership saved"
    else
      render :new
    end
  end

  def edit
    @membership = @organization.memberships.find(params[:id])
    @posts = @organization.posts.pluck(:label, :id)
  end

  def update
    @membership = @organization.memberships.find(params[:id])
    if @membership.update(membership_params)
      redirect_to admin_organization_path(@organization), notice: "Membership updated"
    else
      @posts = @organization.posts.pluck(:label, :id)
      render :edit
    end
  end

  def destroy
    membership = @organization.memberships.find(params[:id])
    membership.destroy
    redirect_to admin_organization_path(@organization)
  end

  private

  def set_organization
    @organization = Popolo::Organization.includes(:memberships).find(params[:organization_id])
  end

  def membership_params
    handle_date_params(params[:membership], "start_date")
    handle_date_params(params[:membership], "end_date")
    params.require(:membership).permit(:label, :role, :post_id, :person_id, :organization_id,
      :start_date, :end_date, 
      sources_attributes: [:url, :note, :_destroy, :id], 
      links_attributes: [:url, :note, :_destroy, :id],
      contact_details_attributes: [:label, :type, :value, :note, :_destroy, :id])
  end

end