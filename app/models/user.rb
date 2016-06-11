class User < ActiveRecord::Base
  has_secure_password
  has_many :boards
  has_many :posts
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                      message: "only allows email format" },
                    presence: true,
                    uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
end
