class DonationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_donation, only: %i[show edit update destroy mark_in_progress mark_as_done]

  # GET /donations or /donations.json
  def index
    @sent_books_donations = Donation.where(sending_user: current_user).includes([:sended_book, :sending_user])
    @received_books_donations = Donation.where(receiving_user: current_user).includes([:sended_book, :sending_user])
    @others_donations = Donation.available.where.not(sending_user: current_user).includes([:sended_book, :sending_user])
  end

  def mark_in_progress
    respond_to do |format|
      if @donation.update!(receiving_user_id: current_user.id, process_status: 'in progress')
        format.html { redirect_to donation_url(@donation), notice: 'Donation was successfully marked in progress.' }
        format.json { render :show, status: :update, location: @donation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_as_done
    respond_to do |format|
      if @donation.update!(process_status: 'done')
        format.html { redirect_to donation_url(@donation), notice: 'Donation was successfully marked as done.' }
        format.json { render :show, status: :update, location: @donation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /donations/1 or /donations/1.json
  def show; end

  # GET /donations/new
  def new
    @donation = Donation.new
  end

  # GET /donations/1/edit
  def edit; end

  # POST /donations or /donations.json
  def create
    @donation = Donation.new(donation_params.merge(sending_user_id: current_user.id, process_status: 'waiting'))

    respond_to do |format|
      if @donation.save
        format.html { redirect_to donation_url(@donation), notice: 'Donation was successfully created.' }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donations/1 or /donations/1.json
  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { redirect_to donation_url(@donation), notice: 'Donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1 or /donations/1.json
  def destroy
    @donation.update(deleted: true)

    respond_to do |format|
      format.html { redirect_to donations_url, notice: 'Donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_donation
    @donation = Donation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def donation_params
    params.require(:donation).permit(:sended_book_id, :sending_status, :process_status)
  end
end
