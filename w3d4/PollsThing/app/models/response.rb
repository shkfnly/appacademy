class Response < ActiveRecord::Base
  validates_presence_of :user_id, :answer_id
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_poll_author

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :response_question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
      response_question.question_responses
        .where("user_id = ?", self.user_id)
        .where("? is NULL or responses.id != ?", self.id, self.id)
  end

  # def sibling_again
  #   SELECT *
  #   FROM responses
  #   JOIN answer_choices
  #   ON answer_choices.id = responses.answer_id
  #   JOIN questions
  #   ON questions.id = answer_choices.question_id
  #   WHERE answer_choices.id = self.answer_id AND self.user_id = p
  # end
#NOPE NOT DONE


  def poll_author
    response_question.poll.author.id == self.user_id
  end

  # def does_not_respond_to_own_poll
  #
  # end

  private
    def respondent_has_not_already_answered_question
      errors[:already_answered] << "can't answer again" if sibling_responses.exists?
    end

    def respondent_is_not_poll_author
      errors[:user_is_poll_author] << "can't answer your own poll" if poll_author
    end

end
