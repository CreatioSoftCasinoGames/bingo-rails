class TournamentUsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_tournament_user, only: [:show, :edit, :update, :destroy]

  # GET /tournament_users
  # GET /tournament_users.json
  def index
    @tournament_users = TournamentUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tournament_users }
    end
  end

  # GET /tournament_users/1
  # GET /tournament_users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tournament_user }
    end
  end

  # GET /tournament_users/new
  def new
    @tournament_user = TournamentUser.new
  end

  # GET /tournament_users/1/edit
  def edit
  end

  # POST /tournament_users
  # POST /tournament_users.json
  def create
    @tournament_user = TournamentUser.new(tournament_user_params)

    respond_to do |format|
      if @tournament_user.save
        format.html { redirect_to @tournament_user, notice: 'Tournament user was successfully created.' }
        format.json { render json: @tournament_user, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @tournament_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournament_users/1
  # PATCH/PUT /tournament_users/1.json
  def update
    respond_to do |format|
      if @tournament_user.update(tournament_user_params)
        format.html { redirect_to @tournament_user, notice: 'Tournament user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tournament_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournament_users/1
  # DELETE /tournament_users/1.json
  def destroy
    @tournament_user.destroy
    respond_to do |format|
      format.html { redirect_to tournament_users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament_user
      @tournament_user = TournamentUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_user_params
      params.require(:tournament_user).permit(:tournament_id, :user_id, :round, :daubs, :bingos, :coins, :attempt_number)
    end
end
