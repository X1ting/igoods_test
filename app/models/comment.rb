class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  validates :body, presence: true

  def can_be_edited? # I wrote two methods which doing seem operations because business logick must be human readable, and when we wan't difference destroy and update logic, it will be simplier than with "can_be_edited_or_destroy?"
    DateTime.now  < (created_at + 15.minute)
  end

  def can_be_destroyed?
    can_be_edited?
  end

  def creator? user
    self.user == user
  end

end
