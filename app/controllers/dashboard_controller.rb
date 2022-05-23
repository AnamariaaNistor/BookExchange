class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @exchanges = Exchange.first(12)
    @donations = Donation.first(12)
    # render 'dashboard/index',  @exchanges,  @donations
  end
end
