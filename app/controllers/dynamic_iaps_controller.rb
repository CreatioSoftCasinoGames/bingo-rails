class DynamicIapsController < ApplicationController
  before_action :set_dynamic_iap, only: [:show, :edit, :update, :destroy]

  # GET /dynamic_iaps
  # GET /dynamic_iaps.json
  def index
    if params[:currency].present?
      @dynamic_iaps = DynamicIap.where(currency: params[:currency])
    else
      @dynamic_iaps = DynamicIap.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dynamic_iaps }
    end
  end

  # GET /dynamic_iaps/1
  # GET /dynamic_iaps/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dynamic_iap }
    end
  end

  # GET /dynamic_iaps/new
  def new
    @dynamic_iap = DynamicIap.new
  end

  # GET /dynamic_iaps/1/edit
  def edit
  end

  # POST /dynamic_iaps
  # POST /dynamic_iaps.json
  def create
    @dynamic_iap = DynamicIap.new(dynamic_iap_params)

    respond_to do |format|
      if @dynamic_iap.save
        format.html { redirect_to @dynamic_iap, notice: 'Dynamic iap was successfully created.' }
        format.json { render json: @dynamic_iap, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @dynamic_iap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dynamic_iaps/1
  # PATCH/PUT /dynamic_iaps/1.json
  def update
    respond_to do |format|
      if @dynamic_iap.update(dynamic_iap_params)
        format.html { redirect_to @dynamic_iap, notice: 'Dynamic iap was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dynamic_iap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dynamic_iaps/1
  # DELETE /dynamic_iaps/1.json
  def destroy
    @dynamic_iap.destroy
    respond_to do |format|
      format.html { redirect_to dynamic_iaps_url }
      format.json { head :no_content }
    end
  end

  def set_time
    
  end

  def special_deal_end_time
    @special_deal = DynamicIap.where(iap_type: "Special", is_active: true)
    results = @special_deal.collect {|sd| [sd.update_attributes(end_time: params[:end_time]), sd.id] }
    if results.collect(&:first).all? {|a| a}
      render json: {
        redirect_to: dynamic_iaps_url,
        message: "Time successfully added.",
        success: true
      }
    else
      render json: {
        redirect_to: set_time_dynamic_iaps_url,
        message: results,
        success: false
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dynamic_iap
      @dynamic_iap = DynamicIap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dynamic_iap_params
      params.require(:dynamic_iap).permit(:old_value, :new_value, :old_pricing, :new_pricing, :offer, :currency, :country, :iap_id, :iap_type, :deal_value, :is_active, :more)
    end
end
