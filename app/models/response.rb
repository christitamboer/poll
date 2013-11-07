class Response < ActiveRecord::Base
  validates :respondent, :answer_choice, :presence => true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_author

  attr_accessible :respondent, :answer_choice, :user_id, :answer_choice_id

  belongs_to(
    :respondent,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  belongs_to(
    :answer_choice,
    :class_name => "AnswerChoice",
    :foreign_key => :answer_choice_id,
    :primary_key => :id
    )

    def respondent_has_not_already_answered_question
      if new_record?
        return existing_responses.empty?
      else
        return existing_responses == self.id
      end
    end

    def respondent_is_not_author
      User.select("COUNT(users.id) as user_count")
        .joins(authored_polls: {questions: :answer_choices})
        .where("answer_choices.id = ?", self.answer_choice_id)
        .where("users.id = ?", self.user_id)
        .first.user_count.zero?
    end

    private
    def existing_responses
      Response.find_by_sql(<<-SQL, [self.answer_choice_id, self.user_id])
      SELECT responses.id
      FROM responses
      JOIN answer_choices
      ON responses.answer_choice_id = answer_choices.id
      WHERE answer_choices.question_id =
        (SELECT a.question_id FROM answer_choices a
        WHERE a.id = ?)
      AND user_id = ?
      SQL
    end
end