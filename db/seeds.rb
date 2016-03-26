User.create(email: 'test@user.com', password: '12345678', nick: 'AwesomeUser')

50.times do
  tag = ActsAsTaggableOn::Tag.find_or_initialize_by(name: Faker::Lorem.word)
  tag.save
end
20.times do
  Article.create(title: Faker::Lorem.word.capitalize, text: Faker::Lorem.paragraph(5), user: User.first, tag_list: ActsAsTaggableOn::Tag.all.pluck(:name).sample(rand(3)))
end