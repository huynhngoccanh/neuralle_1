class Order < ActiveRecord::Base

  has_many :order_items, dependent: :delete_all
  belongs_to :plan
  has_one :brief_request, dependent: :delete

  before_save :update_total_price

  enum payment_type: [:bitpay, :stripe]

  def update_total_price
    podcast_products_price, content_products_price, management_products_price, distribution_products_price, rss_products_price = 0, 0, 0, 0, 0

    if order_items.podcast.present?
      order_items.podcast.each { |o| podcast_products_price += o.product.price * o.quantity }
      if podcast_products_price > 0
        podcast_products_price += Product.product_type("podcast-setup").take.price
      end
    end
    if order_items.content.present?
      order_items.content.each { |o| content_products_price += o.product.price * o.quantity }
      if content_products_price > 0
        content_products_price += Product.product_type("content-setup").take.price
      end
    end
    order_items.management.each { |o| management_products_price += o.product.price * o.quantity } if order_items.management.present?
    order_items.distribution.each { |o| distribution_products_price += o.product.price * o.quantity } if order_items.distribution.present?

    rss_order_item = order_items.rss_distribution.take
    if rss_order_item.present?
      rss_product = Product.product_type("rss_distribution").take
      rss_products_price = rss_order_item.quantity * rss_product.price
    end

    if plan.try(:price)
      price = plan.price +
              management_products_price +
              distribution_products_price
    else
      price = podcast_products_price +
              content_products_price +
              management_products_price +
              distribution_products_price
    end

    unless plan.try(:name) == "Content"
      price += rss_products_price
    end

    price = price + price * 0.10 if subscription_type == 1

    price = price - price * 0.10 if check_discount_code

    self.total_price = price.ceil

    self.total_price = 0.5 if nullified?
  end

  def check_discount_code
    if discount_code.present? && discount_code_correct?
      self.discount_code_applied = true
    end
    discount_code_applied
  end

  def discount_code_correct?
    correct_discount_codes = ["uncommon", "UNCOMMON", "NEUMEDIA", "Podcast"]
    correct_discount_codes.include? discount_code
  end

  def pay
    self.paid = true
    self.save
  end

  def nullified?
    discount_code == "just50cents"
  end

end
