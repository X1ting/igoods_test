class Article < ActiveRecord::Base
  belongs_to :user
  validates :title, :user_id, presence: true

  self.per_page = 5
end
