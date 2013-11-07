class User < ActiveRecord::Base

  validates :user_name, :presence => true, :uniqueness => true
  attr_accessible :user_name, :authored_polls, :responses
  has_many(
    :authored_polls,
    :class_name => "Poll",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :responses,
    :class_name => "Response",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  def completed_polls
    results = responded_polls

    results.select {|result| result.response_count == result.question_count}
  end

  def uncompleted_polls
    results = responded_polls

    results.select {|result| result.response_count != result.question_count}
  end

  private
  def responded_polls
    results = Poll.find_by_sql(["SELECT polls.*, COUNT(responses.id) as response_count, COUNT(questions.id) as question_count
    FROM users
    LEFT OUTER JOIN responses
    ON responses.user_id = users.id
    LEFT OUTER JOIN answer_choices
    ON responses.answer_choice_id = answer_choices.id
    LEFT OUTER  JOIN questions
    ON questions.id = answer_choices.question_id
    LEFT OUTER  JOIN polls
    ON polls.id = questions.poll_id
    WHERE users.id = ?",self.id])
  end
end