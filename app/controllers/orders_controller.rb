class OrdersController < ApplicationController
  before_action :set_order
  before_action :set_plans
  before_action :set_products
  before_action :set_order_items

  def edit
  end

  def update
    @order.update(order_params)
    respond_to :js
  end

  def agree_to_terms
    @order.update(order_params)
    if current_order.terms_agreed && @order.total_price > 0
      redirect_to checkout_page_path
    else
      redirect_to pricing_page_path(anchor: "terms-wrapper")
    end
  end

  def reset_order
    @order.plan_id = nil
    @order.subscription_type = 2
    @order.terms_agreed = false
    @order.total_price = 0
    @order.discount_code = nil
    @order.discount_code_applied = false
    @order.order_items.each do |oi|
      oi.quantity = 0
      oi.save
    end
    @order.paid = false
    @order.save

    @order.brief_request.destroy

    respond_to :js
  end

  private

    def set_order
  		@order = current_order

      Product.all.each do |p|
        order_item = @order.order_items.where(product_id: p.id).first
          OrderItem.create(order_id: @order.id, product_id: p.id) unless order_item.present?
      end

      BriefRequest.create(order_id: @order.id) unless @order.brief_request.present?
      @brief_request = @order.brief_request
  	end

    def set_plans
      @plans = Plan.order("position ASC")
  	end

    def set_products
      @podcast_products = Product.product_type("podcast").order("position ASC")
      @content_products = Product.product_type("content").order("position ASC")

      @podcast_setup_product = Product.product_type("podcast-setup").take
      @content_setup_product = Product.product_type("content-setup").take

      @management_products = Product.product_type("management").order("position ASC")
      @distribution_products = Product.product_type("distribution").order("position ASC")

      @rss_distribution_product = Product.product_type("rss_distribution").take

      @management_product_price = @management_products.take.price
      @distribution_product_price = @distribution_products.take.price

      @rss_distribution_product_price = @rss_distribution_product.price
  	end

    def set_order_items
      @order_items = @order.order_items.present.order("created_at DESC")

      @podcast_order_items = @order_items.podcast
      @content_order_items = @order_items.content
      @management_order_items = @order.order_items.present.management
      @distribution_order_items = @order_items.distribution

      @rss_distribution_order_item = @order.order_items.rss_distribution.take
    end

    def order_params
      params.require(:order).permit(:terms_agreed, :total_price, :subscription_type, :plan_id, :discount_code)
    end

end
