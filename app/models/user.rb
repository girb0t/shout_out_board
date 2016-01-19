class User < ActiveRecord::Base
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                      message: "only allows email format" },
                    presence: true,
                    uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
