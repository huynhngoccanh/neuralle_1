module ApplicationHelper
  def footer_display_name(footer)
    name_elements = []
    name_elements << footer.text if footer.text.present?
    name_elements << icon(footer.icon) if footer.icon.present?
    name_elements.join(' ')
  end

  def display_footer(footer)
    if footer.link.present?
      link_to raw(footer_display_name(footer)), footer.link
    else
      footer_display_name(footer)
    end
  end

  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || "alert-#{flash_type}"
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissable fade in", role: 'alert') do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

  def first_refinery_page_default_part
    Refinery::Pages.default_parts.first.try(:[], :slug)
  end

  def get_blog_image_url(post)
    post_body = Nokogiri::HTML(post.body)
    post_body.xpath('//img').first.try(:attr, 'src')
  end

  # Order helpers

  def order_items
    @order.order_items.present.order("created_at DESC")
  end

  def podcast_order_items
    @order.order_items.present.podcast.order("created_at DESC")
  end

  def content_order_items
    @order.order_items.present.content.order("created_at DESC")
  end

  def management_order_items
    @order.order_items.present.management.order("created_at DESC")
  end

  def distribution_order_items
    @order.order_items.present.distribution.order("created_at DESC")
  end

  def rss_distribution_order_item
    @order.order_items.rss_distribution.take
  end

  def podcast_setup_product
    Product.product_type("podcast-setup").take
  end

  def content_setup_product
    Product.product_type("content-setup").take
  end

  def order_plan?
    @order.plan.try(:price).present? && @order.plan.price > 0
  end

  def review_product(order_item)
    order_item.product.try(:name)
  end

  def review_product_quantity(order_item)
    order_item.quantity
  end

  def set_discount(price)
    price = price + price * 0.10 if @order.subscription_type == 1
    price.ceil
  end

  def formatted_price(price, with_discount = true)
    price = with_discount ? set_discount(price) : price
    number_with_precision(
      price,
      strip_insignificant_zeros: true,
      precision: 2
    )
  end

  def formatted_price_with_symbol(price)
    "$ #{formatted_price(price)}"
  end

  def review_product_price(order_item)
    price = order_item.product.try(:price) * order_item.quantity
    formatted_price_with_symbol(price)
  end

  def total_price
    "$ #{formatted_price(@order.total_price, false)}"
  end

  def page_controller_class
    class_name = "#{params[:controller].gsub("/", " ")}_page #{params[:action]}_action"
    class_name += ' podcast' if request.path == '/podcast'
    class_name
  end

end
