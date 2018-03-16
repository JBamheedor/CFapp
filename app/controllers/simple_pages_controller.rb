class SimplePagesController < ApplicationController
  def index
  end



  def landing_page
    @products = Product.all
  end

  # def thank_you
  #   @name = params[:name]
  #   @email = params[:email]
  #   @message = params[:message]
  #   ActionMailer::Base.mail(from: @email,
  #       to: 'jmbromehead@gmail.com',
  #       subject: "A new contact form message from #{@name}",
  #       body: @message).deliver_now
  # end

  def thank_you
  @name = params[:name]
  @email = params[:email]
  @message = params[:message]
  UserMailer.contact_form(@email, @name, @message).deliver_now
end

end
