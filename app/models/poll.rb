class Poll < ActiveRecord::Base

  validates :author, :presence => true
  attr_accessible :author, :title, :questions, :user_id

  belongs_to(
    :author,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :questions, :dependent => :destroy,
    :class_name => "Question",
    :foreign_key => :poll_id,
    :primary_key => :id
  )
end