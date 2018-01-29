class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show]
  before_action :authenticate_user!

  # GET /dashboards
  def index
  end

end
