class Board < ActiveRecord::Base
  has_many :categories
  validates :key, presence: true, uniqueness: true
  validates :title, presence: true
  validates :active, presence: true

  def self.is_unique_key?(key)
    return self.where(key: key).empty?
  end

  def to_board_stage_json
    self.to_json(:only => [:key, :title, :active],
                 :include => { :categories => {:only => [:title],
                                               :include => {:posts => {:only => [:body]}}}
                                              }
                )
  end
end
