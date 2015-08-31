class HomeController < ApplicationController
  def index
    @organizations = Popolo::Organization.all
    @posts = Popolo::Post.all
    
  end
end
