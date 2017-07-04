class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :fname, presence: true, length: { maximum: 25 }
  validates :lname, presence: true, length: { maximum: 25 }
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                                    uniqueness: { case_sensitive: false } 
  validates :password, presence: true, length: { minimum: 6, maximum: 255 }
  has_secure_password
  
  def full_name
    return "#{fname} #{lname}"
  end
end
