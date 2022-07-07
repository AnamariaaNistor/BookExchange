class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: %i[show edit update destroy accept_request decline_request]

  # GET /requests or /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1 or /requests/1.json
  def show; end

  # GET /requests/new
  def new
    @exchange_id = params[:exchange_id]
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit; end

  # POST /requests or /requests.json
  # DESCRIPTION: when a user applies for an exchange with one o it's books
  def create
    @request = Request.new(request_params.merge(request_user_id: current_user.id, status: 0))

    respond_to do |format|
      if @request.save
        format.html do
          redirect_to exchange_url(@request.exchange_requested), notice: 'Request was successfully created.'
        end
        format.json { render :show, status: :created, location: @request.exchange_requested }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept_request
    @request.update!(status: 1)
    @request.exchange_requested.update!(receiving_user: @request.request_user, received_book: @request.request_book)
    Request.where(exchange_requested_id: @request.exchange_requested.id).excluding(@request).each do |request|
      request.update!(status: 2)
    end
    Exchange.where(id: @request.exchange_requested.id).update(process_status: 1)

    respond_to do |format|
      format.html do
        redirect_to exchange_url(@request.exchange_requested), notice: 'Request was successfully been accepted.'
      end
      format.json { render :show, status: :created, location: @request.exchange_requested }
    end
  end

  def decline_request
    @request.update!(status: 2)

    respond_to do |format|
      format.html { redirect_to exchange_url(@request.exchange_requested), notice: 'Request was successfully been accepted.' }
      format.json { render :show, status: :created, location: @request.exchange_requested }
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to request_url(@request), notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:request_book_id, :exchange_requested_id, :details)
  end
end
