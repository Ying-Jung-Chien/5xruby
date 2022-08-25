# README

* Ruby version: 3.0.0

* Rails version: 7.0.3.1

## Database Models

* Model: 

  * Task info:
 
 Column    |              Type              | Nullable |           Description
-----------|--------------------------------|----------|-----------------------------------
id         | bigint                         | not null | primary key
user_id    | integer                        |          | owner id (temporarily empty)
header     | character varying              | not null | task header
content    | text                           | not null | task content
priority   | integer                        | not null | task priority (high -> low, 2 -> 0)
status     | integer                        | not null | task status (pending : 2, processing : 1, solved : 0)  
start_time | timestamp without time zone    | not null | task start time
end_time   | timestamp without time zone    | not null | task end time
created_at | timestamp(6) without time zone | not null | task build time
updated_at | timestamp(6) without time zone | not null | the last edit time of the task

  * User info:

 Column    |              Type              | Nullable |            Description
-----------|--------------------------------|----------|-----------------------------------
id         | bigint                         | not null | primary key
name       | character varying              | not null | user name
password   | character varying              | not null | password, only allows: length >= 8, at least one digit and upper/lower character
position   | character varying              | not null | user or supervisor
created_at | timestamp(6) without time zone | not null | build time
updated_at | timestamp(6) without time zone | not null | last edit time

## Heroku

* [Address](https://tranquil-citadel-65329.herokuapp.com/)


* App Information
  * home page: /users
  * /users
    * Switch Language
    * Add User
      * users/new : create user with user name, password, position
    * List of all users
      * Edit User -> users/edit : edit name/password/position
      * Delete User
  * tasks
    * Switch Language
    * Add Task
      * tasks/new : create task with task header, content, priority, status, start time, end time
    * List of all tasks
      * Edit task -> tasks/edit : edit header/content/priority/status/start time/end time
      * Delete task

* Deployment instructions
  1. Create Account
  2. Install the Heroku CLI (Ubuntu)
  ```
  curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
  ```
  3. Login
  ```
  heroku login
  ```
  4. Update Code
  ```
  # Gemfile
  + group :production do    
  +   gem 'pg'
  +   gem 'rails_12factor'
  +   gem 'heroku-deflater'   
  + end
  
  # config/routes.rb
  + root "users#index"
  
  # enviroments/production.rb
  config.assets.compile = true
  ```
  5. bundle
  ```
  bundle install
  ```
  6. Deploy
  ```
  git add .
  git commit -m "{some messages}"
  git push -f heroku {branch name}:master
  heroku run rake db:migrate
  heroku open
  ```
