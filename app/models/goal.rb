class Goal < ActiveRecord::Base
  validates :content, :user, presence: true
  validates :is_private, :is_complete, inclusion: { in: [true, false] }

  belongs_to :user

  after_initialize :ensure_privacy_defined

  def complete?
    is_complete
  end

  def ensure_privacy_defined
    self.is_private ||= false
  end

  def mark_complete!
    self.is_complete = true
    self.save
  end

  def private?
    is_private
  end

  def public?
    !is_private
  end

  def viewable_by?(other_user)
    other_user == user || public?
  end
end
