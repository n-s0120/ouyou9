class Book < ApplicationRecord
 belongs_to :user
 has_many :book_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy

 def favorited_by?(user)
  favorites.where(user_id: user.id).exists?
 end

 validates :title, presence: true
 validates :body, presence: true, length: {maximum: 200}
 validates :evaluation, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }
  
  scope :created_at, -> {order(created_at: :desc)}
  scope :evaluation, -> {order(evaluation: :desc)}
 
 def self.search(searches, keywords)
   if searches == "perfect_match"
	  @book = Book.where("title LIKE? OR body LIKE?", "#{keywords}", "#{keywords}")
   elsif searches == "forward_match"
    @book = Book.where("title LIKE? OR body LIKE?", "#{keywords}%", "#{keywords}%")
   elsif searches == "backward_match"
    @book = Book.where("title LIKE? OR body LIKE?", "%#{keywords}", "%#{keywords}")
   else
    @book = Book.where("title LIKE? OR body LIKE?", "%#{keywords}%", "%#{keywords}%")
   end
 end
end