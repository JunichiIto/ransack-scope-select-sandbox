Student.destroy_all

Student.create!(name: 'Alice')
bob = Student.create!(name: 'Bob')
bob.exams.create!(subject: 'English', score: 55)
bob.exams.create!(subject: 'math', score: 70)
bob.exams.create!(subject: 'Japanese', score: 40)

carol = Student.create!(name: 'Carol')
carol.exams.create!(subject: 'English', score: 77)
carol.exams.create!(subject: 'math', score: 61)
carol.exams.create!(subject: 'Japanese', score: 72)
