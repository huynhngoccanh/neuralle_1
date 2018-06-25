class OrderItem < ActiveRecord::Base

  belongs_to :product
  belongs_to :order

  validates_uniqueness_of :product_id, scope: :order_id
	validates :product_id, presence: true
	validates :order_id, presence: true

  scope :present, ->{ where("quantity > ?", 0) }
  scope :podcast, ->{ joins(:product).where(products: { product_type: "podcast" }) }
  scope :content, ->{ joins(:product).where(products: { product_type: "content" }) }
  scope :management, ->{ joins(:product).where(products: { product_type: "management" }) }
  scope :distribution, ->{ joins(:product).where(products: { product_type: "distribution" }) }
  scope :rss_distribution, ->{ joins(:product).where(products: { product_type: "rss_distribution" }) }

end
