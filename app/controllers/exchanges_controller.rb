class ExchangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exchange, only: %i[show edit update destroy mark_as_done]

  # GET /exchanges or /exchanges.json
  def index
    @sent_books_exchanges = Exchange.where(sending_user: current_user).includes([:sended_book, :sending_user])
    @recieved_books_exchanges = Exchange.where(recieving_user: current_user).includes([:sended_book, :sending_user])

    @others_exchanges = Exchange.availible.where.not(sending_user: current_user).includes([:sended_book, :sending_user])

    @my_exchanges_requests = Request.where(exchange_requested_id: Exchange.where(sending_user_id: current_user.id).ids,
                                           status: 0).includes([:exchange_requested, :request_book, :request_user])

    @my_requests = Request.where(request_user_id: current_user.id).includes([:request_book, exchange_requested: [:sended_book, :sending_user]])
  end

  # GET /exchanges/1 or /exchanges/1.json
  def show
    @exchange_requests = Request.where(exchange_requested_id: params[:id]).includes([:request_book, :request_user])
  end

  # GET /exchanges/new
  def new
    @exchange = Exchange.new
  end

  # GET /exchanges/1/edit
  def edit; end

  # POST /exchanges or /exchanges.json
  def create
    @exchange = Exchange.new(exchange_params.merge(sending_user_id: current_user.id, process_status: 'waiting'))

    respond_to do |format|
      if @exchange.save
        format.html { redirect_to exchange_url(@exchange), notice: 'Exchange was successfully created.' }
        format.json { render :show, status: :created, location: @exchange }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_as_done
    respond_to do |format|
      if @exchange.done!
        format.html { redirect_to exchange_url(@exchange), notice: 'Exchange was successfully marked as done.' }
        format.json { render :show, status: :update, location: @exchange }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exchanges/1 or /exchanges/1.json
  def update
    respond_to do |format|
      if @exchange.update(exchange_params)
        format.html { redirect_to exchange_url(@exchange), notice: 'Exchange was successfully updated.' }
        format.json { render :show, status: :ok, location: @exchange }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exchanges/1 or /exchanges/1.json
  def destroy
    @exchange.destroy

    respond_to do |format|
      format.html { redirect_to exchanges_url, notice: 'Exchange was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exchange
    @exchange = Exchange.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def exchange_params
    params.require(:exchange).permit(:sending_user_id, :sended_book_id, :details)
  end
end
