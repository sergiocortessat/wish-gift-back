class User < ApplicationRecord
    validates :sub, :email, presence: true, uniqueness: { case_sensitive: false }
    validates :name, presence: true
end
