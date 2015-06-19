class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    inverse_of: :comments

  belongs_to :post,
    inverse_of: :comments

  belongs_to :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id

  has_many :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id,
    dependent: :destroy

end
