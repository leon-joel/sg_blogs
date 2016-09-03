class Entry < ActiveRecord::Base
  belongs_to :blog
  has_many :comments, -> { order "created_at ASC" }, dependent: :destroy

  validates :title,
            presence: true
  validates :body,
            presence: true

end
