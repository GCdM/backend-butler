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


num_of_households.sample.times do

  house = Household.create(name: Faker::Address.street_address)

  num_of_users.sample.times do

    name = Faker::Name.name
    user = User.create(username: name.downcase, display_name: name, password: "guest", household: house)

    num_of_expenses.sample.times do

      Expense.create(user: user, title: Faker::Food.dish, description: Faker::Food.description, date: Faker::Date.between(100.days.ago, Date.today), amount: rand(300), category: "expense")
    end
  end

  puts "Household: #{house.id}"
  puts "Users: #{house.users.length}"
  puts "Expenses: #{house.expenses.length}"
end

puts "____________________"
puts "------ Seeded ------"
puts "____________________"
