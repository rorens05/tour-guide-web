AdminUser.find_or_create_by(email: 'admin@thesis.com').update_attributes(
  name: 'Laurence Bautista',
  role: 'Super Admin',
  status: 'Active',
  password: 'Password@123'
)