#!/bin/sh

# # Function to check if the database is ready
# check_db() {
#   until nc -z -v -w30 localhost 5432
#   do
#     echo "Waiting for database connection..."
#     sleep 5
#   done
# }

# # Check if the database is ready
# check_db

# # # Run migration
# echo "Starting DB migration deployment........................................................."
# npm run db:migrate:deploy

# # # Check if migration was successful
# if [ $? -eq 0 ]; then
#   echo "===========> Database migration successful."
# else
#   echo "-----> Database migration failed. Exiting."
#   exit 1
# fi

# # Sleep for a few seconds
# sleep 3

# # Seed the database
# echo "Starting DB seeds deployment........................................................."
# npx prisma db seed

# # Check if seeding was successful
# if [ $? -eq 0 ]; then
#   echo "===========> Database seeding successful."
# else
#   echo "-----> Database seeding failed. Exiting."
#   exit 1
# fi

# Sleep for a few seconds
sleep 3

echo "Starting Development mode........................................................."
npm run start:dev
