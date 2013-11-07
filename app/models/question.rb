class Question < ActiveRecord::Base

  validates :poll, :text, :presence => true
  attr_accessible :text, :poll, :answer_choices, :poll_id

  has_many(
    :answer_choices,
    :class_name => "AnswerChoice",
    :foreign_key => :question_id,
    :primary_key => :id, :dependent => :destroy
  )

  belongs_to(
    :poll,
    :class_name => "Poll",
    :foreign_key => :poll_id,
    :primary_key => :id
  )

  def results
    results = Hash.new(0)
    answer_choices.includes(:responses).each do |answer|
      answer.responses.each do |response|
        results[answer.text] += 1
      end
    end

    results
  end
end