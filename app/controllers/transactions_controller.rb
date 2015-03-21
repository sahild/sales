class TransactionsController < ApplicationController
  
  skip_before_action :authenticate_user!,
  only: [:new, :create]
   
 def iframe
   puts "######################################"
    @product = Product.find_by!(permalink: params[:permalink])
    puts "product name " + @product.name
    @sale = Sale.new(product_id: @product)
  end
  
  def new
   @product = Product.find_by!(
   permalink: params[:permalink]
   )
  end
  
  def pickup
   @sale = Sale.find_by!(guid: params[:guid])
   @product = @sale.product
  end
  
  def create
   product = Product.find_by!(
     permalink: params[:permalink]
   )
   @sale = product.sales.create!(
   email: params[:stripeEmail],
   stripe_id: charge.id
   )
   sale.process!
   if sale.finished?
    redirect_to pickup_url(guid: sale.guid)
   else
    flash.now[:alert] = sale.error
    render :new
   end
  end 
  
  def download
    @sale = Sale.find_by!(guid: params[:guid])
   resp = HTTParty.get(@sale.product.file.url)
   filename = @sale.product.file.url
   send_data resp.body,
   :filename => File.basename(filename),
   :content_type => resp.headers['Content-Type']
  end
  
  private

  def strip_iframe_protection
    response.headers.delete('X-Frame-Options')
  end
  
end