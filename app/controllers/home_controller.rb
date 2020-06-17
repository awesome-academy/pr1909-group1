class HomeController < ApplicationController
  def index
    @courses = Course.all.paginate(page: params[:page], per_page: Settings.per_page)
  end

  def about
  end
end
