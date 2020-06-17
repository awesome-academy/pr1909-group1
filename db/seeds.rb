User.create!(
  full_name: "admin",
  email: "admin@gmail.com",
  password:  ENV["ADMIN_PASSWORD"],
  password_confirmation: ENV["ADMIN_PASSWORD"],
  is_admin: true,
  confirmed_at: Time.zone.now)

20.times do |n|
  User.create!(
    full_name: Faker::Name.middle_name.delete("',^"),
    email: "example-#{n+1}@gmail.com",
    password:  "password",
    password_confirmation: "password",
    confirmed_at: Time.zone.now
  )
end

20.times do |n|
  Course.create!(
    user_id: 1,
    course_title: Faker::Lorem.sentence(word_count: 5),
    course_overview: Faker::Lorem.sentence(word_count: 15),
    course_description: Faker::Lorem.sentence(word_count: 40),
    course_type: rand(1..4),
    course_image: Faker::Avatar.image,
    overview_video_url: Faker::File.extension
  )
end
