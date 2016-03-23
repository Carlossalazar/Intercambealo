module Api

  class SessionsController < ApplicationController
   # before_action :set_session, only: [:show, :edit, :update, :destroy]
   before_action :set_authenticate, only: [:new, :create, :authenticate]

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(session_params)

    respond_to do |format|
      if @session.save
        format.json { render :show, status: :created, location: @session }
      else
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.json { render :show, status: :ok, location: @session }
      else
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def authenticate

    user = User.find_by(username: params[:username])
    @session = Session.new
    if user && user.authenticate(params[:password])

      token = rand(36**8).to_s(36)
      date = Time.now

      @session.token = token
      @session.date = date
      @session.id_user = user.id
      @session.save

      render json: @session.token, status: 200 

    else
      render json: @session.errors, status: 422 
    end

    
  end
  def logout


    if Session.find_by(token: params[:token]) 
      @sessions = Session.find(params[:id])
      if @sessions.destroy

        format.json { render json: @sessions, status: 200  }
      end
    else
     render json: {:error => "not-found-authtoken"}.to_json, status: 422
   end
 end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end
    def set_authenticate
      @user = User.find_by_username(params[:username])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:token, :date, :id_user)
    end
  end
end