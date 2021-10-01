user = User.new(
  id: 1,
  email: "rorens05@gmail.com",
  encrypted_password: "$2a$12$OuyDJyImyNertCOOpy8BgevZpfdS5ijHOuoq/dmEDyu9Mgy.ob4jS",
  username: "admin@rorens.com",
  contact_number: "09672854197",
  first_name: "Laurence",
  gender: "Male",
  birthday: nil,
  role: "Player",
  status: "Active",
  confirmation_token: "bafeecbf-3a43-4360-9433-88de4248608e",
  verified_at: nil,
  verification_code: nil,
  verification_sent_at: nil,
  country: "Philippines",
  region_id: 1,
  province_id: 4,
  city_id: 1594,
  last_name: "Bautista",
  login_type: "Email",

)

if !user.save
  puts "Failed to save the user"
  puts user.errors.full_messages.join("\n")
end
