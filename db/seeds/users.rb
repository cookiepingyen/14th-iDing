users = [
  {
    email: 'idingdemo@gmail.com',
    password: 'zpT150QABEgemEw',
    password_confirmation: 'zpT150QABEgemEw',
    confirmed_at: Time.now,
  },
  {
    email: 'ilikefood@gmail.com',
    password: 'gS1v3X6FE2KZt10TbiGO',
    password_confirmation: 'gS1v3X6FE2KZt10TbiGO',
    confirmed_at: Time.now,
  }
]

users.each do |user|
  present_user = User.find_by(email: user[:email])
  if present_user.blank?
    User.create(user)
  end
end
