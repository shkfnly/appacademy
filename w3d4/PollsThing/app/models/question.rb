class Question < ActiveRecord::Base
  validates_presence_of :question_text, :poll_id

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :question_responses,
    :through => :answer_choices,
    :source => :responses
  )

  has_one(
    :author,
    :through => :poll,
    :source => :author
  )

  def results
    result_hash = Hash.new(0)
    answer_choices.includes(:responses).each do |choice|
      result_hash[choice.answer_text] = choice.responses.length
    end
    result_hash
  end

  def slow_results
    result_hash = Hash.new(0)
    answer_choices.each do |choice|
      result_hash[choice.answer_text] = choice.responses.count
    end
    result_hash
  end

  def even_faster_results
    choices = AnswerChoice.find_by_sql([<<-SQL, self.id])
      SELECT
        a.*, COUNT(r.user_id) c
      FROM
        answer_choices a LEFT OUTER JOIN responses r ON a.id = r.answer_id
      WHERE
        a.question_id = 1
      GROUP BY
        a.id
    SQL
    result_hash = Hash.new(0)
    choices.each do |choice|
      result_hash[choice.answer_text] = choice.c
    end
    result_hash
  end
end
