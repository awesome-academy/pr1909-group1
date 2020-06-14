User.create!(
  first_name: "admin",
  last_name: "admin",
  email: "admin@gmail.com",
  password:  ENV["ADMIN_PASSWORD"],
  password_confirmation: ENV["ADMIN_PASSWORD"],
  is_admin: true,
  confirmed_at: Time.zone.now
)

User.create!(
  first_name: "example",
  last_name: "example",
  email: "example@gmail.com",
  password:  "password",
  password_confirmation: "password",
  confirmed_at: Time.zone.now
)
