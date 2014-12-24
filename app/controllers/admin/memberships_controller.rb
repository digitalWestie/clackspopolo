class Admin::MembershipsController < Admin::AdminController

  before_filter :set_organization

  def new
    @membership = @organization.memberships.build
    @posts = @organization.posts.pluck(:label, :id)
    @people = Popolo::Person.all.collect { |p| [p.to_s, p.id] }
  end

  def create
    @membership = @organization.memberships.build(params[:membership])
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

end