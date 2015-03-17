class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @sales = Sale.all
    respond_with(@sales)
  end

  def show
    respond_with(@sale)
  end

  def new
    @sale = Sale.new
    respond_with(@sale)
  end

  def edit
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.save
    respond_with(@sale)
  end

  def update
    @sale.update(sale_params)
    respond_with(@sale)
  end

  def destroy
    @sale.destroy
    respond_with(@sale)
  end

  private
    def set_sale
      @sale = Sale.find(params[:id])
    end

    def sale_params
      params.require(:sale).permit(:email, :guid, :product_id, :stripe_id)
    end
end
