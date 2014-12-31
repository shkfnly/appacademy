require 'singleton'
require 'sqlite3'
require 'byebug'
class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

class QuestionsTables
  def initialize(options)
    options.each { |column, value| instance_variable_set("@#{column}", value) }
  end

  @@qd = QuestionsDatabase.instance

  def save
    insert_string, send_array, set_string, question_marks = define_strings

    if self.class.to_s != "Reply"
      table_name = self.class.to_s.downcase + "s"
    else
      table_name = "replies"
    end

    if id.nil?
      query = <<-SQL
      INSERT INTO
      #{table_name}(#{insert_string})
      VALUES
      #{question_marks}
      SQL
      @@qd.execute(query, *send_array)
      self.id = @@qd.last_insert_row_id

    else
      query = <<-SQL
      UPDATE #{table_name}
      SET #{set_string}
      WHERE id = ?
      SQL
      @@qd.execute(query, *send_array, self.id)
      id
    end
  end

  def define_strings
    var_strings = self.instance_variables.map { |var| var.to_s[1..-1] }
    #insert string
    insert_string = var_strings.join(', ')
    #execute method send-array
    send_array = var_strings.map { |var| self.send(var) }
    #SET/INSERT string
    set_str = set_string(var_strings)
    #Question_marks
    q_marks = question_marks(var_strings)
    [insert_string, send_array, set_str, q_marks]
  end

  def set_string(var_strings)
    set_string = ''
    var_strings.each_with_index do |var, n|
      set_string << var
      set_string << " = ?"
      set_string << ", " unless n == var_strings.length - 1
    end
    set_string
  end

  def question_marks(var_strings)
    question_marks = '('
    var_strings.length.times do |n|
      question_marks << "?"
      question_marks << ", " unless n == var_strings.length - 1
    end
    question_marks << (')')
  end
end

class User < QuestionsTables
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    user_data = @@qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      users.id = ?
    SQL

    user_data.map { |data| User.new(data) }
  end


  def self.find_by_name(fname, lname)
    user_data = @@qd.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL

    user_data.map { |data| User.new(data) }
  end



  def average_karma
    avg_karma_query = <<-SQL
      SELECT (CAST(COUNT(DISTINCT(q.id)) AS FLOAT) / COUNT(ql.user_id))
      FROM questions q
      LEFT OUTER JOIN question_likes ql ON (q.id = ql.question_id)
      WHERE q.author_id = ?
      GROUP BY ql.question_id
      SQL
    avg_karma_data = @@qd.execute(avg_karma_query, id)
    avg_karma_data.first.values[0]
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end
end

class Question < QuestionsTables
  attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(id)
    question_data = @@qd.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL

    question_data.map { |data| Question.new(data) }
  end

  def self.find_by_author_id(author_id)
    questions = @@qd.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL

    questions.map { |data| Question.new(data) }
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def author
    author = @@qd.execute(<<-SQL, self.author_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      SQL
    author.map { |data| User.new(data) }
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollower.followers_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

end

class QuestionFollower < QuestionsTables
  attr_accessor :id, :follower_id, :question_id

  def self.find_by_id(id)
    qf_data = @@qd.execute(<<-SQL, id)
    SELECT * FROM questions WHERE id = ? SQL

    qf_data.map { |data| QuestionFollower.new(data) }
  end

  def self.followers_for_question_id(question_id)
    followers = @@qd.execute(<<-SQL, question_id)
    SELECT u.*
    FROM question_followers qf JOIN users u
    ON qf.follower_id = u.id
    WHERE
      question_id = ?
    SQL

    followers.map { |data| User.new(data) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = @@qd.execute(<<-SQL, user_id)
    SELECT q.*
    FROM question_followers qf JOIN questions q
    ON qf.question_id = q.id
    WHERE
      follower_id = ?
    SQL

    questions.map { |data| Question.new(data) }
  end

  def self.most_followed_questions(n)
    mf_questions = @@qd.execute(<<-SQL, n)
      SELECT q.*
      FROM question_followers qf JOIN questions q
      ON qf.question_id = q.id
      GROUP BY qf.question_id
      ORDER BY COUNT(qf.follower_id) DESC
      LIMIT ?
      SQL
    mf_questions.map {|data| Question.new(data)}
  end
end

class Reply < QuestionsTables
  attr_accessor :id, :question_id, :parent_id, :author_id, :body

  def self.find_by_id(id)
    reply_data = @@qd.execute(<<-SQL, id)
      SELECT * FROM replies
      WHERE id = ?
      SQL

    reply_data.map { |data| Reply.new(data) }
  end

  def self.find_by_question_id(question_id)
    replies_data = @@qd.execute(<<-SQL, question_id)
      SELECT * FROM replies
      WHERE question_id = ?
      SQL

    replies_data.map { |data| Reply.new(data) }
  end

  def self.find_by_user_id(user_id)
    replies_data = @@qd.execute(<<-SQL, user_id)
      SELECT * FROM replies
      WHERE author_id = ?
      SQL

    replies_data.map { |data| Reply.new(data) }
  end

  # def save
  #   if id.nil?
  #     query = <<-SQL
  #     INSERT INTO
  #     replies(question_id, parent_id, author_id, body)
  #     VALUES
  #     (?, ?, ?, ?)
  #     SQL
  #     @@qd.execute(query, question_id, parent_id, author_id, body)
  #     self.id = @@qd.last_insert_row_id
  #
  #   else
  #     query = <<-SQL
  #     UPDATE replies
  #     SET question_id = ?, parent_id = ?, author_id = ?, body = ?
  #     WHERE id = ?
  #     SQL
  #     @@qd.execute(query, question_id, parent_id, author_id, body)
  #     id
  #   end
  # end

  def author
    author_data = @@qd.execute(<<-SQL, self.author_id)
      SELECT * FROM users
      WHERE id = ?
      SQL
    author_data.map { |data| User.new(data) }
  end

  def question
    question_data = @@qd.execute(<<-SQL, self.question_id)
      SELECT * FROM questions
      WHERE id = ?
      SQL
    question_data.map { |data| Question.new(data) }
  end

  def parent_reply
    pr_data = @@qd.execute(<<-SQL, self.parent_id)
      SELECT * FROM replies
      WHERE id = ?
      SQL
    pr_data.map { |data| Reply.new(data) }
  end

  def child_replies
    child_data = @@qd.execute(<<-SQL, self.id)
      SELECT * FROM replies
      WHERE parent_id = ?
      SQL
    child_data.map { |data| Reply.new(data) }
  end

end

class QuestionLike < QuestionsTables
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    ql_data = @@qd.execute(<<-SQL, id)
      SELECT * FROM question_likes
      WHERE id = ?
      SQL

    ql_data.map { |data| QuestionLike.new(data) }
  end

  def self.likers_for_question_id(question_id)
    likers_data = @@qd.execute(<<-SQL, question_id)
      SELECT u.* FROM users u
      JOIN question_likes ql ON ql.user_id = u.id
      WHERE ql.question_id = ?
      SQL

    likers_data.map { |data| User.new(data) }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes_data = @@qd.execute(<<-SQL, question_id)
      SELECT COUNT(*) FROM users u
      JOIN question_likes ql ON ql.user_id = u.id
      WHERE ql.question_id = ?
      SQL

    num_likes_data.first.values[0]
  end

  def self.liked_questions_for_user_id(user_id)
    liked_questions = @@qd.execute(<<-SQL, user_id)
      SELECT q.* FROM questions q
      JOIN question_likes ql ON q.id = ql.question_id
      WHERE ql.user_id = ?
      SQL

    liked_questions.map { |data| Question.new(data) }
  end

  def self.most_liked_question(n)
    ml_questions = @@qd.execute(<<-SQL, n)
      SELECT q.* FROM questions q
      JOIN question_likes ql ON q.id = ql.question_id
      GROUP BY ql.question_id
      ORDER BY COUNT(ql.user_id) DESC
      LIMIT ?
      SQL
    ml_questions.map { |data| Question.new(data) }
  end

end
