class Post < ActiveRecord::Base
  belongs_to :category
  validates :body, presence: true
end
