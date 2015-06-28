# monstr-backend
Monstr is Knowledge Tools (Backend scripts on rails)

# Requirement

MySQL ( or change to other databse in database.yml)  

## Setup

bundle install --path vendor/bundle  
bundle exec rake db:create
bundle exec rake db:migrate

bundle exec rails s (for client) || bundle exec guard (for server)
