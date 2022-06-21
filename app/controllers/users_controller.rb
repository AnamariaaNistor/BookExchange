class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
    @exchanges = Exchange.where(sending_user_id: current_user.id, process_status: 'waiting').includes([:sended_book])
    @donations = Donation.where(sending_user_id: current_user.id, process_status: 'waiting').includes([:sended_book])
  end
end
