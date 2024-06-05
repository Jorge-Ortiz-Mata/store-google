# Prepare DB. If the database exists, it runs the migrations. Otherwise, it creates the database and run the migrations
rails db:prepare

# Run seeds
rails db:seed

# Compile assets
rails assets:precompile

# Launch Rails Server
puma
