# Readme test-pact-im

### Clone project via ssh

`git clone git@github.com:Mi3i4/test-pact-im.git`

### Create `.env` file with fields

```dotenv
RAILS_ENV=development
POSTGRES_USER=db_user
POSTGRES_PASSWORD=db_password
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
```

### Dependencies
```
ruby "3.3.1"
"rails", "~> 7.1.5"
"pg", "~> 1.1"
```
### Install Gems

`bundle install`

### Create db

`rails db:create`

### Run migrations

`rails db:migrate`

### Run tests

`bundle exec rspec`
