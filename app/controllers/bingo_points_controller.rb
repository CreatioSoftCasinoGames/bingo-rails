class BingoPointsController < ApplicationController
  before_action :set_bingo_point, only: [:show, :edit, :update, :destroy]

  # GET /bingo_points
  # GET /bingo_points.json
  def index
    @bingo_points = BingoPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bingo_points }
    end
  end

  # GET /bingo_points/1
  # GET /bingo_points/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bingo_point }
    end
  end

  # GET /bingo_points/new
  def new
    @bingo_point = BingoPoint.new
  end

  # GET /bingo_points/1/edit
  def edit
  end

  # POST /bingo_points
  # POST /bingo_points.json
  def create
    @bingo_point = BingoPoint.new(bingo_point_params)

    respond_to do |format|
      if @bingo_point.save
        format.html { redirect_to @bingo_point, notice: 'Bingo point was successfully created.' }
        format.json { render json: @bingo_point, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @bingo_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bingo_points/1
  # PATCH/PUT /bingo_points/1.json
  def update
    respond_to do |format|
      if @bingo_point.update(bingo_point_params)
        format.html { redirect_to @bingo_point, notice: 'Bingo point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bingo_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bingo_points/1
  # DELETE /bingo_points/1.json
  def destroy
    @bingo_point.destroy
    respond_to do |format|
      format.html { redirect_to bingo_points_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bingo_point
      @bingo_point = BingoPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bingo_point_params
      params.require(:bingo_point).permit(:xp, :cell_coin, :ticket_cost, :theme_level)
    end
end
