class AnswerChoice < ActiveRecord::Base

  validates :question, :text, :presence => true

  attr_accessible :question, :text, :responses, :question_id

  belongs_to(
    :question,
    :class_name => "Question",
    :foreign_key => :question_id,
    :primary_key => :id
  )

  has_many(
    :responses, :dependent => :destroy,
    :class_name => "Response",
    :foreign_key => :answer_choice_id,
    :primary_key => :id
    )
end