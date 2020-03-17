class Answer < ApplicationRecord
	validates :body,  presence:  :true 
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
