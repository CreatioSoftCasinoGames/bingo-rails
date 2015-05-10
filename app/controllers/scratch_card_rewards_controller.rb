class ScratchCardRewardsController < ApplicationController
  before_action :set_scratch_card_reward, only: [:show, :edit, :update, :destroy]

  # GET /scratch_card_rewards
  # GET /scratch_card_rewards.json
  def index
    @scratch_card_rewards = ScratchCardReward.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scratch_card_rewards }
    end
  end

  # GET /scratch_card_rewards/1
  # GET /scratch_card_rewards/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scratch_card_reward }
    end
  end

  # GET /scratch_card_rewards/new
  def new
    @scratch_card_reward = ScratchCardReward.new
  end

  # GET /scratch_card_rewards/1/edit
  def edit
  end

  # POST /scratch_card_rewards
  # POST /scratch_card_rewards.json
  def create
    @scratch_card_reward = ScratchCardReward.new(scratch_card_reward_params)

    respond_to do |format|
      if @scratch_card_reward.save
        format.html { redirect_to @scratch_card_reward, notice: 'Scratch card reward was successfully created.' }
        format.json { render json: @scratch_card_reward, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @scratch_card_reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scratch_card_rewards/1
  # PATCH/PUT /scratch_card_rewards/1.json
  def update
    respond_to do |format|
      if @scratch_card_reward.update(scratch_card_reward_params)
        format.html { redirect_to @scratch_card_reward, notice: 'Scratch card reward was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scratch_card_reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scratch_card_rewards/1
  # DELETE /scratch_card_rewards/1.json
  def destroy
    @scratch_card_reward.destroy
    respond_to do |format|
      format.html { redirect_to scratch_card_rewards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scratch_card_reward
      @scratch_card_reward = ScratchCardReward.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scratch_card_reward_params
      params.require(:scratch_card_reward).permit(:coins, :powerups, :tickets, :key, :chest)
    end
end
