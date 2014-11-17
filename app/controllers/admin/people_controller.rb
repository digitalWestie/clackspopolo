class Admin::PeopleController < ApplicationController

  layout 'admin'
  before_filter :authenticate_admin!

  def index
    @people = Popolo::Person.all
  end

  def new
    @person = Popolo::Person.find(params[:id])
  end

  def create
    @person = Popolo::person.new(person_params)
    respond_to do |format|
      if @person.save
        format.html do
          redirect_to admin_persons_url, notice: 'Person was successfully created.'
        end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @person = Popolo::Person.find(params[:id])
  end

  def update
    @person = Popolo::person.find(params[:id])
    respond_to do |format|
      if @person.update_attributes(person_params)
        format.html do
          redirect_to admin_persons_path,  notice: 'Person was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    p = Popolo::Person.find(params[:id])
    p.destroy
    respond_to do |format|
      format.html { redirect_to admin_people_path }
    end
  end

  private

  def person_params
    params[:person]
  end

end
