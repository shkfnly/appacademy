# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'Ashoker')
User.create(username: 'Amit')
User.create(username: 'AshokersSister')

Contact.create(email: 'amitpamin@gmail.com', name: 'Amit Amin', user_id: 3)
Contact.create(email: 'ashokfinley@gmail.com', name: 'Mr. Finley', user_id: 2)
Contact.create(email: 'sister@gmail.com', name: 'Ms. Finley', user_id: 1)

ContactShare.create(user_id: 2, contact_id: 3)
ContactShare.create(user_id: 1, contact_id: 1)
ContactShare.create(user_id: 3, contact_id: 2)

Comment.create(content: "I am so smart. My name is Ashoka.", commentable_id: 1, commentable_type: "User")
Comment.create(content: "How did you get this? I don't want you to have my sister's info!", commentable_id: 1, commentable_type: "ContactShare")
