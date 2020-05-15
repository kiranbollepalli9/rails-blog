class Post < ApplicationRecord
    validates :title, presence: true, length: {minimun: 6, maximum: 50}
    validates :description, presence: true, length: {minimum: 10, maximum: 1000}
end
