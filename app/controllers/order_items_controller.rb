class OrderItemsController < ApplicationController
  before_action :set_order
  before_action :set_order_items, only: [:update]
  before_action :set_setup_products, only: [:update]


  def create
    @order_item = @order.order_items.new(order_item_params)
    @order_item.save
    @order.update(total_price: @order.update_total_price)
    respond_to :js
  end

  def update
    @order_item.update(order_item_params)
    @order.update(total_price: @order.update_total_price)
    respond_to :js
  end

  private

    def set_order
  		@order = current_order
  	end

    def set_order_items
      @order_item = OrderItem.find(params[:id])
      @order_items = @order.order_items.present.order("created_at DESC")

      @podcast_order_items = @order_items.podcast
      @content_order_items = @order_items.content
      @management_order_items = @order_items.management
      @distribution_order_items = @order_items.distribution
    end

    def set_setup_products
      @podcast_setup_product = Product.product_type("podcast-setup").take
      @content_setup_product = Product.product_type("content-setup").take
    end

    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id, :order_id)
    end
end
