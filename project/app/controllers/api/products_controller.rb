module Api

  class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :product_params, only: [:create]

  # GET /products
  # GET /products.json
  def index
    
      products = Product.all
                render json: products, status: 200
    
  end

  # GET /products/1
  # GET /products/1.json
  def show
    
      if Session.find_by(token: params[:token])
        if @product = Product.find(params[:id])
          render json: @product, status: 200
        else
          render json:{:error => "not-found"}.to_json, status: 422
        end
      else
          render json: {:error => "not-found-authtoken"}.to_json, status: 422
      end
    
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new
    
    if Session.find_by(token: params[:token])


     @product.name = params[:name]
     @product.description = params[:description]
     @product.status = params[:status]
     if @product.save

      render json: @product, status: 201
    else

     render json: @product.errors, status: 422 
   end
   
 else
   render json: @product.errors, status: 402 
 end
 
end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    
    respond_to do |format|

      if Session.find_by(token: params[:token]) 
     
        if @product = Product.find(params[:id])
          
          @product.name = params[:name]
          @product.description = params[:description]
          @product.status = params[:status]
          if @product.save
            format.json { render json: @product, status: 200 }
          end
        else
        format.json { render json: @product.errors, status: 422 }
        end
      else
        format.json { render json: {:error => "not-found-authtoken"}.to_json, status: 422 }
      end

    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    
    head :no_content 
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :status)
    end
  end
end