class User < ApplicationRecord
  has_many :user_properties, dependent: :destroy
  has_many :properties, through: :user_properties
end
