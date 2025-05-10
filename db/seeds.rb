puts 'Start Seeding...'

seeds = %i(users restaurants tables)

seeds.each do |table|
  load "db/seeds/#{table}.rb"
  puts "#{table} seed done."
end

puts 'Seeding Done'
