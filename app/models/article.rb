class Article < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  has_many :comments
  validates :title, :user_id, presence: true

  scope :published, -> { where(not_publish: false) }

  self.per_page = 5
end
