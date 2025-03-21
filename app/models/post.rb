class Post < ApplicationRecord
    belongs_to :user
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
  end