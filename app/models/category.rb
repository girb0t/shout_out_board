class Category < ActiveRecord::Base
  belongs_to :board
  has_many :posts, -> { order(created_at: :asc) }
  validates :title, presence: true
  validates :prompt, presence: true
end
