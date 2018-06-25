require 'bitpay_sdk'

class ChargesController < ApplicationController
  before_action :set_order
  before_action :set_bitpay_service, only: [:bitpay]

  def new
  end

  def create
    @amount = (@order.total_price * 100).to_i

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Neuralle customer',
      :currency    => 'usd'
    )

    @order.pay

    OrderMailer.order_purchase(@order).deliver_later rescue render :create

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def bitpay
    token = SecureRandom.urlsafe_base64
    invoice = @service.create_invoice(@order, bitpay_callback_charges_url(token: token))
    session[:bitpay_token] = token

    redirect_to invoice['url']
  rescue StandardError => ex
    flash[:error] = ex.message
    redirect_to new_charge_path
  end

  def bitpay_callback
    if params[:token] == session[:bitpay_token]
      @order.update(is_paid: true, payment_type: :bitpay)
    end
  end

  private

  def set_order
    @order = current_order
    @brief_request = @order.brief_request
  end

  def set_bitpay_service
    @service = BitpayService.new
  end

end
