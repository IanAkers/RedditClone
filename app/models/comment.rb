class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    inverse_of: :comments

  belongs_to :post,
    inverse_of: :comments
end
