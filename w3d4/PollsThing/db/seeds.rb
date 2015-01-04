# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


15.times do |n|
  name = Faker::Name.name
  User.create!(name: name)
end


10.times do |n|
  title = Faker::Lorem.word
  author_id = rand(15) + 1
  Poll.create!(title: title,
              author_id: author_id)
end

20.times do |n|
  question_text = Faker::Lorem.sentence(3)
  poll_id = rand(10) + 1
  Question.create!(question_text: question_text,
                   poll_id: poll_id)
end

20.times do |n|
  begin
    question_id = rand(20) + 1
    answer_text = Faker::Lorem.word
    AnswerChoice.create!(question_id: question_id,
                        answer_text: answer_text)
  rescue
    retry
  end
end

10.times do |n|
  begin
    user_id = rand(15) + 1
    answer_id = rand(20) + 1
    Response.create!(user_id: user_id,
                     answer_id: answer_id)
  rescue
    retry
  end
end
