# class CheckoutController < ApplicationController

#   def create
#     product = Product.find(params[:id])
#     @session = Stripe::Checkout::Session.create({
#       payment_method_types: ['card'],
#       line_items: [{
#       :name => product.name,
#       :amount => product.price,
#       :currency => 'usd',
#       :quantity => 1,
#       }],
#       mode: 'payment',
#       success_url: root_url,
#       cancel_url: root_url,
#     })
#     respond_to do |format|
#       format.js # render create.js.erb
#     end
#   end
# end

class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: product.name,
          },
          unit_amount: product.price, # amount in cents
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    })
    
    respond_to do |format|
      format.js { render 'create' } # render create.js.erb
      format.html { redirect_to root_path, alert: 'Request format not supported' }
    end
  end
end
