class User < ApplicationRecord
  has_secure_password
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :name, {presence: true}

  def posts
    return Post.where(user_id: self.id)
  end
  #user_idの値が1である「全て」の投稿を取得
  
end
