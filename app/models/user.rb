class User < ApplicationRecord
    validates :user_id, :password, presence: true
end
