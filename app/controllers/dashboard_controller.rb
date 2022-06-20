class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @exchanges = Exchange.includes([:sended_book, :sending_user]).where(process_status: 'waiting').first(12)
    @donations = Donation.includes([:sended_book, :sending_user]).where(process_status: 'waiting').first(12)
  end
end
