if Rails.env.production?
  Rails.configuration.strip = {
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
    secret_key: ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    publishable_key: 'pk_test_MFwtqL1PvQAUNeSkCRmgM9k6',
    secret_key: 'sk_test_1hBBQX6MTmlKQv4M2htQhu1g'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
