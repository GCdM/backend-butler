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
img_urls = [
  'https://react.semantic-ui.com/images/avatar/large/matthew.png',
  'https://react.semantic-ui.com/images/avatar/large/elliot.jpg',
  'https://react.semantic-ui.com/images/avatar/large/daniel.jpg',
  'https://react.semantic-ui.com/images/avatar/large/steve.jpg',
  'https://react.semantic-ui.com/images/avatar/large/molly.png',
  'https://react.semantic-ui.com/images/avatar/large/jenny.jpg',
  'https://react.semantic-ui.com/images/avatar/small/joe.jpg',
  'https://react.semantic-ui.com/images/avatar/small/justen.jpg',
  'https://react.semantic-ui.com/images/avatar/small/helen.jpg',
  'https://react.semantic-ui.com/images/avatar/small/laura.jpg'
]

lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
event_counter = 0


num_of_households.sample.times do

  house = Household.create(name: Faker::Address.street_address)

  num_of_users.sample.times do

    name = Faker::Name.name
    user = User.create(username: name.downcase, display_name: name, password: "guest", household: house, img_url: img_urls.sample)

    num_of_expenses.sample.times do

      Expense.create(user: user, title: Faker::Food.dish, description: Faker::Food.description, date: Faker::Date.between(100.days.ago, Date.today), amount: rand(300), category: "expense")
    end

    num_of_events.sample.times do
      Event.create(household: house, date: Faker::Date.between(Date.today, 100.days.from_now), title: "Event #{event_counter += 1}", description: lorem)
    end
  end

  puts "Household: #{house.id}"
  puts "Users: #{house.users.length}"
  puts "Expenses: #{house.expenses.length}"
  puts "Events: #{house.events.length}"
end

puts "____________________"
puts "------ Seeded ------"
puts "____________________"
