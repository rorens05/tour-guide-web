class HomeController < ApplicationController
  before_action :authenticate_user!

  def index;
  # redirect_to admin_dashboard_path
  end

end
