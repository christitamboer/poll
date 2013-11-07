# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(user_name: "Christi")
user2 = User.create(user_name: "Anujan")
poll = Poll.create(title: "Confidence", user_id: user.id)
question = Question.create(text: "Are you cool?", poll_id: poll.id)
answer_choice1 = AnswerChoice.create(text: "Yes", question_id: question.id)
answer_choice2 = AnswerChoice.create(text: "No", question_id: question.id)
answer_choice3 = AnswerChoice.create(text: "Maybe", question_id: question.id)
response = Response.create(user_id: user2.id, answer_choice_id: answer_choice3.id)