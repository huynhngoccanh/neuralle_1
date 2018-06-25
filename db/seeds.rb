# Some Refinery stuff

# # Added by Refinery CMS Pages extension
# Refinery::Pages::Engine.load_seed
#
# # Added by Refinery CMS Blog engine
# Refinery::Blog::Engine.load_seed
#
# # Custom seed pages
# unless signup_page = Refinery::Page.find_by(:link_url => '/signup')
#   Refinery::Page.create!(
#     :title          => 'Signup',
#     :view_template  => 'signup',
#     :show_in_menu   => false
#   ).tap do |page|
#     Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
#       page.parts.create(
#         title: default_page_part[:title],
#         slug: default_page_part[:slug],
#         :body => nil,
#         :position => index
#       )
#     end
#   end
# end
#
# # Added by Refinery CMS Footers extension
# Refinery::Footers::Engine.load_seed
#
# # Added by Refinery CMS ServiceOptions extension
# Refinery::ServiceOptions::Engine.load_seed
#
# # Added by Refinery CMS Podcasts extension
# Refinery::Podcasts::Engine.load_seed


# Orders seeds

Order.destroy_all
BriefRequest.destroy_all
Product.destroy_all
OrderItem.destroy_all


# Content

Product.create(
  name: "HD Image",
  position: 1,
  price: 100.00,
  product_type: "content"
)
Product.create(
  name: "Video - 10 mins",
  position: 2,
  price: 1000.00,
  product_type: "content"
)
Product.create(
  name: "Video - 5 mins",
  position: 3,
  price: 500.00,
  product_type: "content"
)
Product.create(
  name: "Video - 2 mins",
  position: 4,
  price: 200.00,
  product_type: "content"
)
Product.create(
  name: "Video - 60 sec",
  position: 5,
  price: 100.00,
  product_type: "content"
)
Product.create(
  name: "Video - 30 sec",
  position: 6,
  price: 50.00,
  product_type: "content"
)
Product.create(
  name: "Brief Setup",
  price: 180.00,
  product_type: "content-setup"
)


# Podcast

Product.create(
  name: "Podcast Episode - 60 mins",
  position: 1,
  price: 455.00,
  product_type: "podcast"
)
Product.create(
  name: "Podcast Episode - 45 mins",
  position: 2,
  price: 341.00,
  product_type: "podcast"
)
Product.create(
  name: "Podcast Episode - 30 mins",
  position: 3,
  price: 228.00,
  product_type: "podcast"
)
Product.create(
  name: "Podcast Episode - 15 mins",
  position: 4,
  price: 114.00,
  product_type: "podcast"
)
Product.create(
  name: "Audio Promo - 60 sec",
  position: 5,
  price: 57.00,
  product_type: "podcast"
)
Product.create(
  name: "Brief Setup",
  price: 225.00,
  product_type: "podcast-setup"
)


channels = %w(Instagram YouTube Facebook Twitter LinkedIn Snapchat)

# Management

channels.each_with_index do |channel, i|
  Product.create(
    name: channel,
    position: i + 1,
    price: 550.00,
    product_type: "management"
  )
end


# Distribution

channels.each_with_index do |channel, i|
  Product.create(
    name: channel,
    position: i + 1,
    price: 69.00,
    product_type: "distribution"
  )
end

# RSS Feed Distribution

Product.create(
  name: "RSS Feed Distribution",
  price: 69.00,
  product_type: "rss_distribution"
)
