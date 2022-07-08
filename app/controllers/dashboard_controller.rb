class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @exchanges = Exchange.where.not(sending_user_id: current_user.id).includes([:sended_book, :sending_user]).where(process_status: 'waiting').first(12)
    @donations = Donation.where.not(sending_user_id: current_user.id).includes([:sended_book, :sending_user]).where(process_status: 'waiting').first(12)
  end
end
