require 'acts_as_indexed'
require 'friendly_id'

module Refinery
  module Podcasts
    class Podcast < Refinery::Core::BaseModel
      self.table_name = 'refinery_podcasts'

      acts_as_indexed :fields => [:title, :author, :subtitle, :duration, :keywords, :summary]

      validates :title, :presence => true, :uniqueness => true

      belongs_to :file, :class_name => '::Refinery::Resource'
      belongs_to :image, :class_name => '::Refinery::Image'



      # CarrierWave uploader work around since Dragonfly crashes because of the Heroku worker timout
      mount_uploader :podcast_file, PodcastFileUploader
      process_in_background :podcast_file
      store_in_background :podcast_file
      # validates :podcast_file, presence: true
      validates :file_url, presence: true
      auto_strip_attributes :file_url



      # validates :file, presence: true

      extend FriendlyId

      friendly_id :title, :use => :slugged

      def episode_number
        self.class.order('published_at DESC').
                   where(self.class.arel_table[:id].lteq(self.id)).
                   count
      end

      class << self
        def default_scope
          order "published_at DESC"
        end

        def published
          where arel_table[:published_at].lteq(Date.today)
        end

        def latest(limit = 10)
          published.limit limit
        end
      end
    end
  end
end
