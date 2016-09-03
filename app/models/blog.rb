class Blog < ActiveRecord::Base
  has_many :entries, -> { order "created_at ASC" }, dependent: :destroy

end
