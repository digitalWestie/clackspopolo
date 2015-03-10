class Admin::PeopleController < Admin::AdminController

  def index
    @people = Popolo::Person.all
  end

  def new
    @person = Popolo::Person.new
  end

  def create
    @person = Popolo::Person.new(person_params)
    respond_to do |format|
      if @person.save
        format.html do
          redirect_to admin_people_path, notice: 'Person was successfully created.'
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
    @person = Popolo::Person.find(params[:id])
    respond_to do |format|
      if @person.update_attributes(person_params)
        format.html do
          redirect_to admin_people_path,  notice: 'Person was successfully updated.'
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
    handle_date_params(params[:person], "birth_date")
    handle_date_params(params[:person], "death_date")
    params.require(:people).permit(:name, :family_name, :given_name, :additional_name, :sort_name, 
      :email, :gender, :national_identity, :summary, :biography, :image, :birth_date, :death_date,
      sources: [:url, :note], links: [:url, :note],
      contact_details: [:label, :type, :value, :note])
  end

end
