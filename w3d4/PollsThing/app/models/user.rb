class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )

  SELECT
    polls.*
  FROM
    polls
  JOIN
    questions ON polls.id = questions.poll_id
  JOIN
    answer_choices ON questions.id = answer_choices.question_id
  LEFT OUTER JOIN
    (SELECT
      *
    FROM
      responses
    WHERE
      user_id = 1) own_responses ON answer_choices.id = own_responses.answer_id
  GROUP BY
    polls.id
  HAVING
    COUNT(DISTINCT questions.id) = COUNT(own_responses.user_id);

  # def completed_polls(self.id)
  #  SELECT
  #    p3.id, p3.pc, ur.answer_id, ur.poll_id
  #  FROM
  #     (SELECT
  #       *
  #      FROM responses r
  #         JOIN (SELECT
  #                 *
  #               FROM
  #                 answer_choices a2
  #               JOIN
  #                 questions q2
  #               ON a2.question_id = q2.id) a4
  #         ON r.answer_id = a4.id
  #     WHERE r.user_id = 1 ) ur
  #     JOIN polls p
  #       ON ur.poll_id = p.id
  #     JOIN
   #
  #     (SELECT
  #         p1.id, COUNT(q.id) pc
  #       FROM
  #         questions q
  #         JOIN polls p1 ON q.poll_id = p1.id
  #       WHERE
  #         p1.author_id <> 1
  #       GROUP BY (p1.id)
  #       ) p3
   #
  #        ON p.id = p3.id
  #  GROUP BY p3.id, p3.pc, ur.answer_id, ur.poll_id
   #
  #  HAVING COUNT(ur.answer_id) = p3.pc AND ur.poll_id = p3.id
  # end
end
