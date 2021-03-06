class PostSub < ActiveRecord::Base
  validates :post, :sub, presence: true

  belongs_to :sub
  belongs_to :post,
    inverse_of: :post_subs
end
