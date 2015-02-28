class TournamentRewardsController < ApplicationController
  before_action :set_tournament_reward, only: [:show, :edit, :update, :destroy]

  # GET /tournament_rewards
  # GET /tournament_rewards.json
  def index
    @tournament_rewards = TournamentReward.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tournament_rewards }
    end
  end

  # GET /tournament_rewards/1
  # GET /tournament_rewards/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tournament_reward }
    end
  end

  # GET /tournament_rewards/new
  def new
    @tournament_reward = TournamentReward.new
  end

  # GET /tournament_rewards/1/edit
  def edit
  end

  # POST /tournament_rewards
  # POST /tournament_rewards.json
  def create
    @tournament_reward = TournamentReward.new(tournament_reward_params)

    respond_to do |format|
      if @tournament_reward.save
        format.html { redirect_to @tournament_reward, notice: 'Tournament reward was successfully created.' }
        format.json { render json: @tournament_reward, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @tournament_reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournament_rewards/1
  # PATCH/PUT /tournament_rewards/1.json
  def update
    respond_to do |format|
      if @tournament_reward.update(tournament_reward_params)
        format.html { redirect_to @tournament_reward, notice: 'Tournament reward was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tournament_reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournament_rewards/1
  # DELETE /tournament_rewards/1.json
  def destroy
    @tournament_reward.destroy
    respond_to do |format|
      format.html { redirect_to tournament_rewards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament_reward
      @tournament_reward = TournamentReward.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_reward_params
      params.require(:tournament_reward).permit(:reward_type)
    end
end
