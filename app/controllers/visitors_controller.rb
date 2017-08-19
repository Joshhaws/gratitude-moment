class VisitorsController < ApplicationController

  def index
    if current_user
      redirect_to moments_path
    end
  end

end
