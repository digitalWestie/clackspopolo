class Admin::PostsController < ApplicationController

  layout 'admin'
  before_filter :authenticate_admin!

  def new
    @organization = Popolo::Organization.find(params[:organization_id])
    @post = @organization.posts.build
  end

  def create
    organization = Popolo::Organization.find(params[:organization_id])
    @post = organization.posts.build(params[:post])
    respond_to do |format|
      if @post.save
        format.html do
          redirect_to admin_organization_url(organization), notice: 'Post was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @organization = Popolo::Organization.find(params[:organization_id])
    @post = @organization.posts.find(params[:post_id])
  end

  def update
    organization = Popolo::Organization.find(params[:organization_id])
    @post = organization.posts.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html do
          redirect_to admin_organization_url(organization), notice: 'Post was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    organization = Popolo::Organization.find(params[:organization_id])
    @post = organization.posts.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_organization_path(@organization) }
    end
  end

end
