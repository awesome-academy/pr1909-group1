company_size = ["50-99", "100-299", "300-499", "500-999", "1000"]
salary = [{ min:100, max:500 }, { min:300, max:700 }, { min:500, max:1000 }, { min:1500, max:2000 }]
20.times do |n|
User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "admin-#{n+1}@gmail.com",
  password:  ENV["ADMIN_PASSWORD"],
  password_confirmation: ENV["ADMIN_PASSWORD"],
  user_type: "admin",
  confirmed_at: Time.zone.now)
end

40.times do |n|
User.create!(first_name:  Faker::Name.first_name,
   last_name: Faker::Name.last_name,
   email: "example-#{n+1}@gmail.com",
   user_type: rand(1..2),
   password: "password",
   password_confirmation: "password",
   confirmed_at: Time.zone.now)
end

20.times do |n|
Candidate.create!(
  user_id: 2*n +22,
  date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 100),
  phone: Faker::Base.numerify("+84 ###-###-###"),
  avatar: Faker::Avatar.image,
  cv: "https://robohash.org/#{ Faker::Name.first_name.delete(" ") }.pdf?size=300x300&set=set1")
end

20.times do |n|
Employer.create!(
  user_id: 2*n +21,
  company_logo: Faker::Company.logo,
  company_name: Faker::Company.name,
  company_size: company_size.sample,
  company_description: Faker::Lorem.sentence(word_count: 100))
end

100.times do |n|
  salary_sample = salary.sample
  JobPost.create!(
  employer_id: rand(1..20),
  job_location: rand(1..4),
  job_type: rand(1..4),
  job_status: rand(1..4),
  post_priority: rand(1..5),
  salary_min: salary_sample[:min],
  salary_max: salary_sample[:max],
  post_title: Faker::Job.title,
  job_description: "job_description #{n +1}",
  job_expired_date: Date.today)
end

20.times do |n|
  5.times do |m|
    ApplyActivity.create!(
      job_post_id: (n + 1)*(m + 1),
      candidate_id: n + 1
    )
  end
end
