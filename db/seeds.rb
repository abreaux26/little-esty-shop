# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@bulk_discount_1 = BulkDiscount.create!(percentage_discount: 0.20, quantity_threshold: 15, merchant_id: 1)
@bulk_discount_2 = BulkDiscount.create!(percentage_discount: 0.10, quantity_threshold: 10, merchant_id: 1)

@bulk_discount_3 = BulkDiscount.create!(percentage_discount: 0.12, quantity_threshold: 2, merchant_id: 2)
@bulk_discount_4 = BulkDiscount.create!(percentage_discount: 0.05, quantity_threshold: 4, merchant_id: 2)
