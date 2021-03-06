class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :body, presence: true
  validates :background_color_hex, format: { with: /(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i,
    message: "only allows hex notation"}, allow_blank: true
  validates :font_color_hex, format: { with: /(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i,
    message: "only allows hex notation"}, allow_blank: true
end
