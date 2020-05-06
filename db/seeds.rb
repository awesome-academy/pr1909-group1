company_size = ["50-99", "100-299", "300-499", "500-999", "1000"]
salary = [{ min:100, max:500 }, { min:300, max:700 }, { min:500, max:1000 }, { min:1500, max:2000 }]
candidate = []
employer = []
can_id = []
emp_id = []
post_id = []

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
  user = User.create!(first_name:  Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "example-#{n+1}@gmail.com",
    user_type: rand(1..2),
    password: "password",
    password_confirmation: "password",
    confirmed_at: Time.zone.now)
  if user.candidate?
    candidate<<user.id
  else
    employer<<user.id
  end
end
number_of_candidate = candidate.length
number_of_candidate.times do |n|
  cand = Candidate.create!(
    user_id: candidate[n],
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 100),
    phone: Faker::Base.numerify("+84 ###-###-###"),
    avatar: Faker::Avatar.image,
    cv: Faker::File.extension
  )
  can_id<<cand.id
end

number_of_employer = employer.length
number_of_employer.times do |n|
  emp = Employer.create!(
    user_id: employer[n],
    company_logo: Faker::Company.logo,
    company_name: Faker::Company.name,
    company_size: company_size.sample,
    company_description: Faker::Lorem.sentence(word_count: 100))
  emp_id<<emp.id
end

length_can = 5*number_of_candidate
length_can.times do |n|
  salary_sample = salary.sample
  post = JobPost.create!(
  employer_id: emp_id.sample,
  job_location: rand(1..4),
  job_type: rand(1..4),
  job_status: rand(1..3),
  post_priority: rand(1..5),
  salary_min: salary_sample[:min],
  salary_max: salary_sample[:max],
  post_title: Faker::Job.title,
  job_description: "job_description #{n +1}",
  job_expired_date: Date.today + rand(1..30).days)
  post_id<<post.id
end

number_of_candidate.times do |n|
  5.times do |m|
    ApplyActivity.create!(
      job_post_id: post_id[(n + 1)*(m + 1) - 1],
      candidate_id: can_id[n],
      employer_id: JobPost.find(post_id[(n + 1)*(m + 1) - 1]).employer_id
    )
  end
end
