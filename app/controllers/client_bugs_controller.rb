class ClientBugsController < ApplicationController
  before_action :set_client_bug, only: [:show, :edit, :update, :destroy]

  # GET /client_bugs
  # GET /client_bugs.json
  def index
    @client_bugs = ClientBug.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @client_bugs }
    end
  end

  # GET /client_bugs/1
  # GET /client_bugs/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client_bug }
    end
  end

  # GET /client_bugs/new
  def new
    @client_bug = ClientBug.new
  end

  # GET /client_bugs/1/edit
  def edit
  end

  # POST /client_bugs
  # POST /client_bugs.json
  def create
    @client_bug = ClientBug.new(client_bug_params)

    respond_to do |format|
      if @client_bug.save
        format.html { redirect_to @client_bug, notice: 'Client bug was successfully created.' }
        format.json { render json: @client_bug, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @client_bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_bugs/1
  # PATCH/PUT /client_bugs/1.json
  def update
    respond_to do |format|
      if @client_bug.update(client_bug_params)
        format.html { redirect_to @client_bug, notice: 'Client bug was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @client_bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_bugs/1
  # DELETE /client_bugs/1.json
  def destroy
    @client_bug.destroy
    respond_to do |format|
      format.html { redirect_to client_bugs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_bug
      @client_bug = ClientBug.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_bug_params
      params.require(:client_bug).permit(:exception, :bug_type)
    end
end
