course_type = ["Web Design", "Web Development", "Marketing", "Product Management"]
user_ids = []
course_ids = []
User.create!(
  full_name: "admin",
  email: "admin@gmail.com",
  password:  ENV["ADMIN_PASSWORD"],
  password_confirmation: ENV["ADMIN_PASSWORD"],
  is_admin: true,
  confirmed_at: Time.zone.now)

20.times do |n|
  user = User.create!(
    full_name: Faker::Name.middle_name.delete("',^"),
    email: "example_#{n+1}@gmail.com",
    password:  "password",
    password_confirmation: "password",
    confirmed_at: Time.zone.now
  )
  user_ids<<user.id
end

4.times do |n|
  CourseType.create!(
    course_type: course_type[n]
  )
end

20.times do |n|
  course = Course.create!(
    user_id: 1,
    course_title: Faker::Lorem.sentence(word_count: 5),
    course_overview: Faker::Lorem.sentence(word_count: 15),
    course_description: Faker::Lorem.sentence(word_count: 40),
    course_type_id: rand(1..4),
    course_image: Faker::Avatar.image,
    overview_video_url: Faker::File.extension
  )
  course_ids<<course.id
end

number_users = user_ids.length
number_users.times do |n|
  20.times do |m|
    EvaluateCourse.create!(
      user_id: user_ids[n],
      course_id: course_ids[m],
      star: rand(1..5)
  )
  end
end

number_users.times do |n|
  sample = course_ids.sample(16)
  16.times do |m|
    Register.create!(
      user_id: user_ids[n],
      course_id: sample[m]
    )
  end
end

number_users.times do |n|
  sample = course_ids.sample(16)
  16.times do |m|
    ReviewCourse.create!(
      user_id: user_ids[n],
      course_id: sample[m],
      comment: Faker::Lorem.sentence(word_count: 20)
    )
  end
end
