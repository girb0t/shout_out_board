#TODO add NOT NULL constraint to user_id
class Board < ActiveRecord::Base
  belongs_to :user
  has_many :categories
  has_many :posts, through: :categories
  validates :key, presence: true, uniqueness: true
  validates :user_id, presence: true
  validates :title, presence: true
  validates :active, inclusion: { in: [true, false] }
  validates :archived, inclusion: { in: [true, false] }

  scope :active, -> { where(active: true) }

  def self.is_unique_key?(key)
    return self.where(key: key).empty?
  end

  def self.is_active_key?(key)
    return self.where(key: key, active: true).present?
  end

  def to_board_stage_json
    self.to_json(:only => [:key, :title, :active],
                 :include => { :categories => {:only => [:title],
                                               :include => {:posts => {:only => [:body, :background_color_hex, :font_color_hex]}}}
                                              }
                )
  end
end
