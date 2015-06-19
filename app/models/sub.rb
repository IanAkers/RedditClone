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
  belongs_to :moderator,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :subs

  has_many :posts
end
