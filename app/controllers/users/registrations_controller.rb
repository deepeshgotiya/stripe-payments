class Users::RegistrationsController < Devise::RegistrationsController
  before_create: create_stripe_customer

  def create
    super do |resource|
      resource.stripe_customer_id = @stripe_customer.id
    end
  end

  private 

  def create_stripe_customer
   @stripe_customer = Stripe::Customer.create(
      name: params[:name],
      email: params[:email]
    )
  end
end