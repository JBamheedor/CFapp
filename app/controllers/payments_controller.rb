class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])

    if user_signed_in?
      @user = current_user
    else
      redirect_to new_user_session
    end

    token = params[:stripeToken]
    # Create the charge on Stripe's servers - this will charge the user's card

    begin
      charge = Stripe::Charge.create(
        amount: (@product.price).to_i,
        currency: 'usd',
        source: token,
        description: params[:stripeEmail],
        receipt_email: params[:stripeEmail]
      )

    if charge.paid
      Order.create(product_id: @product.id, user_id: @user.id, total: @product.price)
    end

  rescue Stripe::CardError => e
    #Declined card
    body = e.json_body
    err = body[:error]
    flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
  end

  end
end
