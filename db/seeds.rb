# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!({
  email: "andrewritter@wesellmeat.com", password: 111111, firstname: "Andrew", lastname: "Ritter", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, role: "admin"
})

puts "#{User.count} Users Created!"

Location.create!({
  location_name: "Tarleton", location_address: "1123 Research Blvd, Austin TX 78769", location_contact_name: "Joeleen Smith", location_contact_email: "jsmith@tarleton.com", location_contact_phone: "512-555-5555", location_notes: "Park in Back"
})

puts "#{Location.count} Locations Created!"

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

100.times do
  location = Location.all.sample
  location.jobs.create!({
    job_location: location.location_name,
    job_address: location.location_address,
    job_date: "1-10-2018",
    job_time: "12:00:00",
    job_estimated_hours: 5,
    job_sport: Sport.all.sample.sport_name,
    job_notes: "Park In Back"
  })
end

puts "#{Job.count} Jobs Created!"
