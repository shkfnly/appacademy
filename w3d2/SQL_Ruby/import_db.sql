CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  follower_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (follower_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  author_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id)   REFERENCES replies(id),
  FOREIGN KEY (author_id)   REFERENCES users(id)

);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
  users (fname, lname)
VALUES
('Ashoka', 'Finley'), ('Mike', 'Golubitsky'), ('Santa', 'Clause');


INSERT INTO
  questions(title, body, author_id)
VALUES
  ('life', 'What is the meaning of life?',
    (SELECT id from users WHERE fname = 'Mike')),
  ('App Academy', 'How long does it take to become a programmer?',
    (SELECT id from users WHERE fname = 'Ashoka')),
  ('Science', 'What is the speed of light?',
    (SELECT id FROM users WHERE fname = 'Ashoka'));

INSERT INTO
  question_followers(follower_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Mike'),
    (SELECT id FROM questions WHERE title = 'Science')),
  ((SELECT id FROM users WHERE fname = 'Ashoka'),
    (SELECT id FROM questions WHERE title = 'life')),
  ((SELECT id FROM users WHERE fname = 'Santa'),
    (SELECT id FROM questions WHERE title = 'App Academy'));

INSERT INTO
  replies(question_id, parent_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Science'),
    null,
   (SELECT id FROM users WHERE fname = 'Mike'),
    '299 792 458 m / s'
    ),

  ((SELECT id FROM questions WHERE title = 'Science'),
   (SELECT id from replies WHERE parent_id IS NULL),
   (SELECT id FROM users WHERE fname = 'Santa'),
   'Rudolph'
  ),

  ((SELECT id FROM questions WHERE title = 'App Academy'),
  null,
  (SELECT id FROM users WHERE fname = 'Santa'),
    'Jobs available at north pole immediately.'
  );

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Ashoka'), (SELECT id FROM questions WHERE title = 'App Academy')),

  ((SELECT id FROM users WHERE fname = 'Santa'),
    (SELECT id FROM questions WHERE title = 'Science')) ;
