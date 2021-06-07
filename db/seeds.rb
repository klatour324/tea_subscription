# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Subscription.destroy_all
Customer.destroy_all
Tea.destroy_all

customers = FactoryBot.create_list(:customer, 5)
teas = FactoryBot.create_list(:tea, 5)

subscription1 = FactoryBot.create(:subscription, customer_id: customers[0].id , tea_id: teas[0].id)
subscription2 = FactoryBot.create(:subscription, customer_id: customers[0].id, tea_id: teas[1].id)
subscription3 = FactoryBot.create(:subscription, customer_id: customers[1].id, tea_id: teas[1].id)
subscription4 = FactoryBot.create(:subscription, customer_id: customers[2].id, tea_id: teas[2].id)
subscription5 = FactoryBot.create(:subscription, customer_id: customers[2].id, tea_id: teas[3].id)
subscription6 = FactoryBot.create(:subscription, customer_id: customers[3].id, tea_id: teas[3].id)
subscription7 = FactoryBot.create(:subscription, customer_id: customers[3].id, tea_id: teas[1].id)
subscription8 = FactoryBot.create(:subscription, customer_id: customers[4].id, tea_id: teas[2].id)
subscription9 = FactoryBot.create(:subscription, customer_id: customers[4].id, tea_id: teas[4].id)
subscription10 = FactoryBot.create(:subscription, customer_id: customers[4].id, tea_id: teas[0].id)
