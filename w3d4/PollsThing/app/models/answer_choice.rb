class AnswerChoice < ActiveRecord::Base
  validates_presence_of :question_id, :answer_text
  validate :answer_choice_already_exists_within_question


  belongs_to(
    :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :answer_id,
    primary_key: :id
  )

  def sibling_answers
    question.answer_choices
      .where("answer_text = ?", self.answer_text)
      .where("? is NULL OR answer_choices.id != ?", self.id, self.id)
  end

  private
    def answer_choice_already_exists_within_question
      errors[:already_present] << "can't add more than one answer with same name" if sibling_answers.exists?
    end

end
