class Board < ActiveRecord::Base
  has_many :categories
  validates :key, presence: true, uniqueness: true
  validates :title, presence: true
  validates :active, presence: true

  def self.is_unique_key?(key)
    return self.where(key: key).empty?
  end
end
