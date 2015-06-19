# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)
#  content    :text
#  sub_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :subs, :author, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :authored_posts

  has_many :post_subs,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id,
    dependent: :destroy,
    inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments,
    dependent: :destroy,
    inverse_of: :post
end
