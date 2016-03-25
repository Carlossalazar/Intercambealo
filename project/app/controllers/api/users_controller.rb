module Api
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all 
    if name = params[:firstname]
      @users = @users.where(firstname: fistname)
    end
    render json: @users, status: 200
  end

  # GET /users/1
  # GET /users/1.json
  def show
     @user = User.find(params[:id])
    render json: @user, status: 200
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
       
        render json: @user, status: 201
      else
       
         render json: @user.errors, status: 422
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
   if Session.find_by(token: request.headers['token']) 
        
        if @user = User.find(params[:id])
         @user.username = params[:username]
         @user.password = params[:password]
         @user.password_confirmation = params[:password_confirmation]
         @user.firstname = params[:firstname]
          if @user.save
            format.json { render json: @user, status: 200 }
          end
        else
            format.json { render json: @user.errors, status: 422 }
        end
      else
      format.json { render json: {:error => "not-found-authtoken"}.to_json, status: 422 }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    
    respond_to do |format|
    if Session.find_by(token: request.headers['token'])
        if @user = User.find(params[:id])
          @user.destroy
          format.json {render json: {:echo => "succesfull"}.to_json, status: 200}

        end
      else
      format.json {render json: {:error => "not-found-authtoken"}.to_json, status: 422}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:username, :password, :password_confirmation, :firstname)
    end
end
end
