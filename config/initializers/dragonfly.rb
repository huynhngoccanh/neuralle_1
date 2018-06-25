Dragonfly.app.configure do
  url_host = 'http://cdn.neuralle.com' if Rails.env.production?
end
