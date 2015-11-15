class Category < ActiveRecord::Base
  belongs_to :board
  has_many :posts
  validates :title, presence: true
  validates :prompt, presence: true
end
