# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

num_of_households = [2, 3, 4, 5, 6]
num_of_users = [2, 3, 4, 5, 6, 7, 8]
num_of_expenses = [1, 2, 3]
num_of_events = [1, 2]
num_of_resps = [3, 4, 5, 6, 7]
num_of_resp_users = [2, 3, 4, 5]

lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
event_counter = 0


num_of_households.sample.times do

  house = Household.create(name: Faker::Address.street_address)

  num_of_users.sample.times do

    name = Faker::Name.name
    img = Faker::Avatar.image
    user = User.create(username: name.downcase, display_name: name, password: "guest", household: house, img_url: img)

  end

  num_of_resps.sample.times do
    Responsibility.create(household: house, title: Faker::TheITCrowd.quote)
  end

  house.users.each do |user|

    num_of_expenses.sample.times do

      Expense.create(user: user, title: Faker::Food.dish, description: Faker::Food.description, date: Faker::Date.between(100.days.ago, Date.today), amount: rand(300), category: "expense")
    end

    num_of_events.sample.times do
      Event.create(household: house, date: Faker::Date.between(Date.today, 100.days.from_now), title: "Event #{event_counter += 1}", description: lorem)
    end

    num_of_resp_users.sample.times do
      ResponsibilityUser.create(responsibility: house.responsibilities.sample, user: user, description: Faker::Lebowski.quote, date: Faker::Date.between(100.days.ago, Date.today))
    end
  end

end

puts "____________________"
puts "------ Seeded ------"
puts "____________________"
