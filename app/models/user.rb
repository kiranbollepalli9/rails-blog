class User < ApplicationRecord
    before_save { self.email = email.downcase }

    has_many :posts

    validates :username, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: {in: 3..20}
    
    EMAIL_VALIDATION_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i;

    validates :email, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: {in: 6..50},
                        format: {with: EMAIL_VALIDATION_REGEX }                    
    
end