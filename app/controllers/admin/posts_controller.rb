class Admin::PostsController < ApplicationController

  layout 'admin'
  before_filter :authenticate_admin!

  def new
    @organization = Popolo::Organization.find(params[:organization_id])
    @post = @organization.posts.build
  end

  def create
    @organization = Popolo::Organization.find(params[:organization_id])
    @post = @organization.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html do
          redirect_to admin_organization_url(@organization), notice: 'Post was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @organization = Popolo::Organization.find(params[:organization_id])
    @post = @organization.posts.find(params[:id])
  end

  def update
    @organization = Popolo::Organization.find(params[:organization_id])
    @post = @organization.posts.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html do
          redirect_to admin_organization_path(@organization), notice: 'Post was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @organization = Popolo::Organization.find(params[:organization_id])
    @post = @organization.posts.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_organization_path(@organization) }
    end
  end

  private

  def post_params
    handle_date_params(params[:post], "start_date")
    handle_date_params(params[:post], "end_date")
  end

end
