class Question < ApplicationRecord
	validates :title, :body, :category, presence:  :true 
  belongs_to :user
  has_many :answers, dependent: :destroy 
  has_many :comments, as: :commentable, dependent: :destroy 

  before_save do
  self.category.gsub!(/[\[\]\"]/, "") if attribute_present?("category")
	end
end
