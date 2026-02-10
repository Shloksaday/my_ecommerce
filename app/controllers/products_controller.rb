class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.includes(:products)

    if params[:query].present?
      @products = Product.where(
        "LOWER(name) LIKE :q OR LOWER(description) LIKE :q",
        q: "%#{params[:query]}%"
      )
    else
      @products = Product.all
    end
  end

  def show
    # @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    
    @product = Product.new(product_params)
    
    if @product.save
      UserMailer.order_confirmation(@product).deliver_now
      redirect_to @product, notice: 'Product created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Product deleted successfully'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :price,
      :description,
      :category_id,
      :image
    )
  end
  
end
