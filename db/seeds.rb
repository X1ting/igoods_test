User.create(email: 'test@user.com', password: '12345678', nick: 'AwesomeUser')

20.times do
  Article.create(title: Faker::Lorem.word.capitalize, text: Faker::Lorem.paragraph(5), user: User.first)
end