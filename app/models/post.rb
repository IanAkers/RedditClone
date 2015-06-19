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
  validates :title, :sub, :author, presence: true

  belongs_to :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :authored_posts

  belongs_to :sub,
    inverse_of: :posts
end
