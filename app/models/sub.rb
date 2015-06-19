# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Sub < ActiveRecord::Base
  validates :title, :description, presence: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :subs

    has_many :post_subs,
      class_name: "PostSub",
      foreign_key: :sub_id,
      primary_key: :id,
      dependent: :destroy

    has_many :posts,
      through: :post_subs,
      source: :post

end
