class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @user = current_user

    token = params[:stripeToken]
    # Create the charge on Stripe's servers - this will charge the user's card

    begin
      charge = Stripe::Charge.create(
        amount:        @product.price * 100, 
        currency:      'usd',
        source:        token,
        description:   params[:stripeEmail],
        receipt_email: params[:stripeEmail]
      )

      if charge.paid
        Order.create(product_id: @product.id, user_id: @user.id, total: @product.price)
        flash[:notice] = "Your payment was processed successfully"
      end

    # this will never really reached when using the checkout.js
    rescue Stripe::CardError => e
      #Declined card
      body          = e.json_body
      err           = body[:error]
      flash[:alert] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
    end

    redirect_to product_path(@product)

  end
end