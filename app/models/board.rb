class Board < ActiveRecord::Base
  has_many :categories
  has_many :posts, through: :categories
  validates :key, presence: true, uniqueness: true
  validates :title, presence: true
  validates :active, inclusion: { in: [true, false] }

  def self.is_unique_key?(key)
    return self.where(key: key).empty?
  end

  def self.is_active_key?(key)
    return self.where(key: key, active: true).present?
  end

  def to_board_stage_json
    self.to_json(:only => [:key, :title, :active],
                 :include => { :categories => {:only => [:title],
                                               :include => {:posts => {:only => [:body]}}}
                                              }
                )
  end
end
