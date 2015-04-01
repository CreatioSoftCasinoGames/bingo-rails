class BotBingoNumbersController < ApplicationController
  before_action :set_bot_bingo_number, only: [:show, :edit, :update, :destroy]

  # GET /bot_bingo_numbers
  # GET /bot_bingo_numbers.json
  def index
    @bot_bingo_numbers = BotBingoNumber.all

    respond_to do |format|
      format.html # index.html.erb
      # frommat.json { render json: @bot_bingo_numbers }
    end
  end

  # GET /bot_bingo_numbers/1
  # GET /bot_bingo_numbers/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bot_bingo_number }
    end
  end

  # GET /bot_bingo_numbers/new
  def new
    @bot_bingo_number = BotBingoNumber.new
  end

  # GET /bot_bingo_numbers/1/edit
  def edit
  end

  # POST /bot_bingo_numbers
  # POST /bot_bingo_numbers.json
  def create
    @bot_bingo_number = BotBingoNumber.new(bot_bingo_number_params)

    respond_to do |format|
      if @bot_bingo_number.save
        format.html { redirect_to @bot_bingo_number, notice: 'Bot bingo number was successfully created.' }
        format.json { render json: @bot_bingo_number, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @bot_bingo_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bot_bingo_numbers/1
  # PATCH/PUT /bot_bingo_numbers/1.json
  def update
    respond_to do |format|
      if @bot_bingo_number.update(bot_bingo_number_params)
        format.html { redirect_to @bot_bingo_number, notice: 'Bot bingo number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bot_bingo_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bot_bingo_numbers/1
  # DELETE /bot_bingo_numbers/1.json
  def destroy
    @bot_bingo_number.destroy
    respond_to do |format|
      format.html { redirect_to bot_bingo_numbers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bot_bingo_number
      @bot_bingo_number = BotBingoNumber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bot_bingo_number_params
      params.require(:bot_bingo_number).permit(:number_of_bots, :starting_number)
    end
end
