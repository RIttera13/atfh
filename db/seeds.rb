# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!({
  email: "andrewritter@wesellmeat.com", password: 111111, firstname: "Andrew", lastname: "Ritter", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, role: "admin", phone_number: "512-555-5555"
})

puts "#{User.count} Users Created!"

Organization.create!({
  organization_name: "Tarleton", organization_address: "1123 Research Blvd, Austin TX 78769", organization_contact_name: "Joeleen Smith", organization_contact_email: "jsmith@tarleton.com", organization_contact_phone: "512-555-5555", organization_notes: "Park in Back"
})

puts "#{Organization.count} Organizations Created!"

Sport.create!([
  {sport_name: "Football"},
  {sport_name: "Baseball"},
  {sport_name: "Softball"},
  {sport_name: "Men's Soccer"},
  {sport_name: "Women's Soccer"},
  {sport_name: "Men's Basketball"},
  {sport_name: "Women's Basketball"},
  {sport_name: "Swimming"},
  {sport_name: "Tennis"},
  {sport_name: "Lacross"},
  {sport_name: "Gymnastics"},
  {sport_name: "Martial Arts"}
])

puts "#{Sport.count} Sports Created!"

30.times do

  day = 1.times.map{ 0+Random.rand(90) }.join.to_i
  organization = Organization.all.sample
  organization.jobs.create!({
    job_organization: organization.organization_name,
    job_address: organization.organization_address,
    job_date: rand(day).days.from_now.strftime("%m/%d/%Y"),
    job_time: Time.at((rand(day).days.ago.to_f - rand(day).days.ago.to_f)*rand + rand(day).days.ago.to_f).strftime("%l:%M %p"),
    job_estimated_hours: 5,
    job_sport: Sport.all.sample.sport_name,
    job_notes: "Park In Back"
  })
end

puts "#{Job.count} Jobs Created!"

100.times do

  genNumber = Random.rand(1..9)
  day = 1.times.map{ 0+Random.rand(180) }.join.to_i
  jdate = rand(day).days.ago
  jtime = Time.at((rand(day).days.ago.to_f - rand(day).days.ago.to_f)*rand + rand(day).days.ago.to_f)
  jstart = DateTime.new(jdate.year, jdate.month, jdate.day, jtime.to_time.hour, jtime.to_time.min, jtime.to_time.sec)
  jend = jstart + genNumber.hours
  organization = Organization.all.sample
  user = User.all.sample
  organization.jobs.create!({
    job_organization: organization.organization_name,
    job_address: organization.organization_address,
    job_date: jdate.strftime("%m/%d/%Y"),
    job_time: jtime.strftime("%l:%M %p"),
    job_estimated_hours: 5,
    job_sport: Sport.all.sample.sport_name,
    job_notes: "Park In Back",
    primary_id: user.id,
    job_start_time: jstart.strftime("%m/%d/%Y %l:%M %P"),
    job_end_time: jend.strftime("%m/%d/%Y %l:%M %P"),
    job_actual_hours: genNumber,
    job_completed: true,
    job_approved: true
  })
end

puts "#{Job.count} Jobs Created!"
