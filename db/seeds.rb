# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(name: "admin", title: "Role for admin", description: "This user can do anything", the_role: '{"system":{"administrator":true}}')
Role.create(name: "guest", title: "Role for guest", description: "guest", the_role: '{"products":{"index":true,"show":true,"only_pro":true}}')
Role.create(name: "shop", title: "Role for shop", description: "shop", the_role: '{"products":{"new":true,"create":true,"show":true,"index":true}}')
Role.create(name: "administrator", title: "Role for administrator", description: "administrator", the_role: '{"products":{"index":true,"show":true,"edit":true,"update":true,"set_pro":true}}')

# {
# "admin":{"title":"Role for admin","description":"This user can do anything","role_hash":{"system":{"administrator":true}}}
# ,"user":{"title":"user","description":"user","role_hash":{"products":{"index":true,"show":true,"only_pro":true}}},
# "shop":{"title":"shop","description":"shop","role_hash":{"products":{"new":true,"create":true,"show":true,"index":true}}},
# "administrator":{"title":"administrator","description":"administrator","role_hash":{"products":{"index":true,"show":true,"edit":true,"update":true,"set_pro":true}}},
# "export_comment":"EXPORT Roles: *admin, user, shop, administrator*"
# }
