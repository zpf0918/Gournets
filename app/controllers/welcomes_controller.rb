class WelcomesController < ApplicationController

  def index
   flash[:notice] = "fighting"
  end
end
