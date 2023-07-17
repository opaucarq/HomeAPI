class Property < ApplicationRecord
  has_many :user_properties, dependent: :destroy
  has_many :users, through: :user_properties
end
