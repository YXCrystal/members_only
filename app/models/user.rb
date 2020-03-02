class User < ApplicationRecord    
    before_save { self.email = email.downcase }

    validates :username, presence: true, length: { maximum: 50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
              format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    
    validates :password, presence: true, length: { minimum: 6 }

    has_secure_password

    has_many :posts

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? Bcrypt::Engine::MIN_COST : Bcrypt::Engine.cost
        Bcrypt::Password.create(string, cost: cost)

    end

    def User.new_token
        SecureRandom.urlsafe_based64
    end

    def remember
        self.remember_token = User.new_token
        update_attributes(:remember_digest, User.digest(remember_token))
    end
end
