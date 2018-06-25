Refinery::Podcasts.configure do |config|
  # What your podcast show is called.
  #
  config.title = "Uncommon | Learn From Unique Individuals, The Ultimate Way To Improve Yourself"

  # A subtitle/byline for your podcast show
  #config.subtitle = "If all you have is a hammer, everything looks like a nail. Abraham Maslow."

  # The contents of this tag are shown in a separate window that appears when the
  # "circled i" in the Description column is clicked. It also appears on the iTunes
  # page for your podcast. This field can be up to 4000 characters.
  #
  config.description = "The Uncommon podcast is designed to build your knowledge, skills, processes, tools and mindset, which will ultimately make both you and I, better individuals, professionals, business owners or investors.
We do this by interviewing unique individuals that have included; Venture Capitalists, Bodybuilders, Hedge Fund Managers, Political Activists, Comedians, Tech Founders, Chefs, Rappers, and Restaurateurs to name just a few.
Our style is conversational, 1on1, and can go from 45 minutes to 2 hours long. I’m inspired by the likes of Tim Ferriss, Joe Rogan, Charlie Rose, Oprah Winfrey & Charlie Munger. In particular, Charlie Munger inspired me to create this podcast and help you build your wordly wisdom.
Learn more about our guests at: neuralle.com/podcast. 
Intro Song: Birds Away by SFT"

  # The content of this tag is shown in the Artist column in iTunes.
  config.author = "Neuralle Co-Founders, Jordan Michaelides & Lauren Lopatko"

  # This tag should be used to indicate whether or not your podcast contains
  # explicit material. The three values for this tag are "yes", "no", and "clean".
  #
  config.explicit_content = "yes"

  # Accepted values are those in the ISO 639-1 Alpha-2 list
  # (two-letter language codes, some with possible modifiers, such as 'en-us').
  #
  config.language = "en-us"

  # iTunes prefers square .jpg or .png images that are between
  # 1400 x 1400 pixels and 3000 x 3000 pixels
  # You could upload an image to your resources tab and link it in here.
  #
  config.image_url = ENV['PODCAST_IMAGE']

  # select from the list of categories here:
  # https://help.apple.com/itc/podcasts_connect/?lang=en#/itc9267a2f12
  #
  # config.category = "Business"
  # config.subcategory = "Investing"

  # The owner name and email tags contain information that will be used to
  # contact the owner of the podcast for communication specifically about their
  # podcast. It should not be publicly displayed.
  #
  config.owner_name = "Jordan Michaelides"
  config.owner_email = "jordan@neuralle.com"
end
