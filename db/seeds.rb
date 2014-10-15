# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Popolo::Organization.destroy_all
Popolo::Person.destroy_all
Popolo::Membership.destroy_all
Popolo::Post.destroy_all


council = Popolo::Organization.create(name: 'Clackmannanshire Council', classification: 'Local Authority')

labour = Popolo::Organization.create(name:'Labour Party', classification: 'Political Party')
tories = Popolo::Organization.create(name:'Conservative Party', classification: 'Political Party')
nats   = Popolo::Organization.create(name:'SNP', classification: 'Political Party')
libdems   = Popolo::Organization.create(name:'Liberal Democrats', classification: 'Political Party')
greens = Popolo::Organization.create(name:'Green Party', classification: 'Political Party') # no greens...

puts "Created #{Popolo::Organization.count} organizations"

councillors = []

#Clackmannanshire Central

councillors << Popolo::Person.create(name: 'Derek', family_name:'Stewart')# , Labour
labour.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Gary', family_name:'Womersley') #, Scottish National Party
nats.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Graham', family_name:'Watt') #, Labour
labour.memberships.create(person:councillors.last)

#Clackmannanshire East

councillors << Popolo::Person.create(name: 'Alastair', family_name:'Campbell') #, Conservative
tories.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Irene', family_name:'Hamilton') #, Scottish National Party
nats.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Kathleen', family_name:'Martin') #, Labour
labour.memberships.create(person:councillors.last)

#Clackmannanshire North

councillors << Popolo::Person.create(name: 'Archie', family_name:'Drummond')# , Independent
#what to do with independents? Guess they aren't a member of any org?

councillors << Popolo::Person.create(name: 'Donald W.', family_name:'Balsillie')# , Scottish National Party
nats.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Robert', family_name:'McGill')# , Labour
labour.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Walter', family_name:'McAdam')#  MBE, Scottish National Party
nats.memberships.create(person:councillors.last)

#Clackmannanshire South

councillors << Popolo::Person.create(name: 'Craig', family_name:'Holden')# , Scottish National Party
nats.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Ellen', family_name:'Forson')# , Scottish National Party
nats.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Janet', family_name:'Cadenhead')# , Labour
labour.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Kenneth', family_name:'Earle')# , Labour
labour.memberships.create(person:councillors.last)

#Clackmannanshire West

councillors << Popolo::Person.create(name: 'George', family_name:'Matchett')#  Q.P.M., Labour
labour.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Jim', family_name:'Stalker')# , Labour
labour.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Les', family_name:'Sharp')# , Scottish National Party
nats.memberships.create(person:councillors.last)

councillors << Popolo::Person.create(name: 'Tina', family_name:'Murphy')# , Scottish National Party
nats.memberships.create(person:councillors.last)

puts "Created #{Popolo::Person.count} people"

######################

# Make councillors members of council
memberships = []
councillors.each do |p|
  memberships << Popolo::Membership.create(person:p, organization:council)
end

# Associate council memberships with councillor post
councillor_post = Popolo::Post.create(organization:council, role: 'Councillor', label: 'Councillor')
memberships.each { |m| councillor_post.memberships << m }

puts "Created #{Popolo::Post.count} posts"

