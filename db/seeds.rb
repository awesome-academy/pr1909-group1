course_type = ["Web Design", "Web Development", "Marketing", "Product Management"]
video_urls = ["https://player.vimeo.com/video/180293809", "https://player.vimeo.com/video/119105386",
              "https://player.vimeo.com/video/69225705", "https://player.vimeo.com/video/61789173",
              "https://player.vimeo.com/video/393999309", "https://player.vimeo.com/video/377600390",
              "https://player.vimeo.com/video/375432709", "https://player.vimeo.com/video/373997050",
              "https://player.vimeo.com/video/372988843", "https://player.vimeo.com/video/368134723",
              "https://player.vimeo.com/video/363921958", "https://player.vimeo.com/video/360832524",
              "https://player.vimeo.com/video/355204808", "https://player.vimeo.com/video/355114615",
              "https://player.vimeo.com/video/348671806", "https://player.vimeo.com/video/45230972",
              "https://player.vimeo.com/video/25641459", "https://player.vimeo.com/video/1904672",
              "https://player.vimeo.com/video/17752439", "https://player.vimeo.com/video/369095"]
user_ids = []
course_ids = []
quiz = []
User.create!(
  full_name: "admin",
  email: "admin@gmail.com",
  password:  ENV["ADMIN_PASSWORD"],
  password_confirmation: ENV["ADMIN_PASSWORD"],
  is_admin: true,
  confirmed_at: Time.zone.now)

40.times do |n|
  user = User.create!(
    full_name: Faker::Name.middle_name.delete("',^"),
    email: "example_#{n+1}@gmail.com",
    password:  "password",
    password_confirmation: "password",
    confirmed_at: Time.zone.now,
    created_at: Faker::Date.between(from: '2020-07-01', to: Time.zone.now)
  )
  user_ids<<user.id
end

20.times do |n|
  user = User.create!(
    full_name: Faker::Name.middle_name.delete("',^"),
    email: "facebook_#{n+1}@gmail.com",
    password:  "password",
    password_confirmation: "password",
    confirmed_at: Time.zone.now,
    created_at: Faker::Date.between(from: '2020-07-05', to: Time.zone.now),
    provider: "facebook"
  )
  user_ids<<user.id
end

20.times do |n|
  user = User.create!(
    full_name: Faker::Name.middle_name.delete("',^"),
    email: "google_#{n+1}@gmail.com",
    password:  "password",
    password_confirmation: "password",
    confirmed_at: Time.zone.now,
    created_at: Faker::Date.between(from: '2020-07-05', to: Time.zone.now),
    provider: "google_oauth2"
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
    overview_video_url: video_urls.sample
  )
  course_ids<<course.id
end

number_users = user_ids.length

# number_users.times do |n|
#   10.times do |m|
#     Like.create!(
#       user_id: user_ids[n],
#       course_id: course_ids[m]
#   )
#   end
# end

number_users.times do |n|
  sample = course_ids.sample(16)
  16.times do |m|
    Register.create!(
      user_id: user_ids[n],
      course_id: sample[m],
      lesson_step: rand(1..18)
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

number_course = course_ids.length
number_course.times do |n|
  20.times do |m|
    lesson = Lesson.create!(
      course_id: course_ids[n],
      lesson_name: Faker::Educator.course_name,
      lesson_type: rand(1..2),
      min_point: rand(3..5),
      lesson_sequence: m +1,
      video_url: video_urls.sample,
      quiz_questions_attributes: [{
        quiz_question: "question 1",
        quiz_choice: { "0"=>{ label: "A", text: "answer A", is_answer: "1" },
                       "1"=>{ label: "B", text: "answer B", is_answer: "0" },
                       "2"=>{ label: "C", text: "answer C", is_answer: "0" },
                       "3"=>{ label: "D", text: "answer D", is_answer: "0" }} },
      {
        quiz_question: "question 2",
        quiz_choice: { "0"=>{ label: "A", text: "answer A", is_answer: "1" },
                       "1"=>{ label: "B", text: "answer B", is_answer: "0" },
                       "2"=>{ label: "C", text: "answer C", is_answer: "0" },
                       "3"=>{ label: "D", text: "answer D", is_answer: "0" }}
                     },
      {
        quiz_question: "question 3",
        quiz_choice: { "0"=>{ label: "A", text: "answer A", is_answer: "1" },
                       "1"=>{ label: "B", text: "answer B", is_answer: "0" },
                       "2"=>{ label: "C", text: "answer C", is_answer: "0" },
                       "3"=>{ label: "D", text: "answer D", is_answer: "0" }}
                     },
      {
        quiz_question: "question 4",
        quiz_choice: { "0"=>{ label: "A", text: "answer A", is_answer: "1" },
                       "1"=>{ label: "B", text: "answer B", is_answer: "0" },
                       "2"=>{ label: "C", text: "answer C", is_answer: "0" },
                       "3"=>{ label: "D", text: "answer D", is_answer: "0" }}
                     },
      {
        quiz_question: "question 5",
        quiz_choice: { "0"=>{ label: "A", text: "answer A", is_answer: "1" },
                       "1"=>{ label: "B", text: "answer B", is_answer: "0" },
                       "2"=>{ label: "C", text: "answer C", is_answer: "0" },
                       "3"=>{ label: "D", text: "answer D", is_answer: "0" }}
                     }]
      )
    quiz<<lesson.id if lesson.quiz?
  end
end
