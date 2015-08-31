class Admin::MotionsController < Admin::AdminController
  
  before_filter :set_organization

  def index
    @motions = @organization.motions
  end

  def new
    @motion = @organization.motions.build
    @people = @organization.memberships.collect { |m| [m.person.to_s, m.person.id] }
  end

  def create
    @motion = @organization.motions.build(motion_params)
    if @motion.save
      redirect_to admin_organization_path(@organization), notice: "Motion saved"
    else
      @people = @organization.memberships.collect { |m| [m.person.to_s, m.person.id] }
      render :new
    end
  end

  def edit
    @motion = @organization.motions.find(params[:id])
    @people = @organization.memberships.collect { |m| [m.person.to_s, m.person.id] }
  end

  def update
    @motion = @organization.motions.find(params[:id])
    if @motion.update(motion_params)
      redirect_to admin_organization_path(@organization), notice: "Motion updated"
    else
      @people = @organization.memberships.collect { |m| [m.person.to_s, m.person.id] }
      render :edit
    end
  end

  def destroy
    motion = @organization.motions.find(params[:id])
    motion.destroy
    redirect_to admin_organization_path(@organization)
  end

  private

  def set_organization
    @organization = Popolo::Organization.includes(:motions).find(params[:organization_id])
  end

  def motion_params
    handle_date_params(params[:motion], "date")
    params.require(:motion).permit(:creator_id, :organization_id, :date,
      :text, :result, :classification, :identifier, 
      sources_attributes: [:url, :note, :_destroy, :id])
  end

end
