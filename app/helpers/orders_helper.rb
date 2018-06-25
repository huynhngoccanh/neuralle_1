module OrdersHelper

  def order_item(product_id)
    @order.order_items.where(product_id: product_id).first # || @order.order_items.new
  end

  def order_item_quantity(product_id)
    order_item(product_id).try(:quantity) || 0
  end

  def formatted_management_total_price
    if @management_order_items.count < 1
      formatted_price_with_symbol(@management_product_price)
    else
      formatted_price_with_symbol(@management_product_price * @management_order_items.count)
    end
  end

  def formatted_distribution_total_price
    if @distribution_order_items.count < 1
      formatted_price_with_symbol(@distribution_product_price)
    else
      formatted_price_with_symbol(@distribution_product_price * @distribution_order_items.count)
    end
  end

  def formatted_rss_distribution_total_price
    if @rss_distribution_order_item.quantity < 1
      formatted_price_with_symbol(@rss_distribution_product_price)
    else
      formatted_price_with_symbol(@rss_distribution_product_price * @rss_distribution_order_item.quantity)
    end
  end

end
