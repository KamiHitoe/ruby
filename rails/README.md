
Rails is a web application development framework written in the Ruby programming lang.
root files are application.html.erb and application.css, application.js.
Rails supports `Webpack` and `Yarn`

# Get Started

```shell
# install
gem install rails
# create app
rails new "APP_NAME"
# api mode without view
rails new "APP_NAME" --api -d "DATABASE" -T # with database without default testing
# run app
bin/rails server # = rails server
# cloud 9 set up
rvm use 2.6.6
```


## install modules

```shell
# config to install without modules for production
bundle config set --local without 'production'
#update
bundle update
# install modules in Gemfile
bundle install
# init webpacker
rails webpacker:install
```


# Directory structure

- Model: app/models/
- View: app/views/
  - Layout: layouts/
- Controller: app/controllers/
- Helper: app/helpers/
- Router: config/routes.rb
- Schema: db/schema.rb
- Asset: app/assets/
  - Image: images/
  - CSS: stylesheets/
- Test: test/
- Gem: Gemfile


## App dev path

1. install gem. create rails app
2. generate controller
3. TDD in test/
4. UI design, transition design
5. routing
6. DB design

# View

- application.html.erb: top html file. this is template file for all view files
  - yield: this is function() or variable that is embedded from other component files
- other component files
  - provide: this sends props to template file by helper function


## Routing

write config/routes.rb

```ruby
Rails.application.routes.draw do
  
  root 'Controllers#homePath'
  # HTTP method
  get 'Controllers/path'
end
```

### Named URL

```ruby:config/routes.rb
# prev
get 'controllers/path'
# next
get '/path', to: 'controller#action' # = pathName/path
```

show all routes
```shell
rails routes
```

### Resourceful Routing

```rb:config/routes.rb
  resources :ctrls
```

```shell
      Prefix Verb   URI Pattern                  Controller#Action
        root GET    /                            ctrls#index
       ctrls GET    /ctrls(.:format)          ctrls#index
 new_article GET    /ctrls/new(.:format)      ctrls#new
     article GET    /ctrls/:id(.:format)      ctrls#show
             POST   /ctrls(.:format)          ctrls#create
edit_article GET    /ctrls/:id/edit(.:format) ctrls#edit
             PATCH  /ctrls/:id(.:format)      ctrls#update
             DELETE /ctrls/:id(.:format)      ctrls#destroy
```

# Embedded ruby(viewFile.html.erb)

it it html file with embedded ruby. it makes `View` role in app

```ruby
# with output
<%=  %>
# without output
<%  %>
# add attribute
<%= , attribute: value %>

# render partial
<%= render "layouts/partial" %>

# link to another pages in views/
<%= link_to "Home", "/home"  %>
# with name path. below is same as above
<%= link_to "Home", home_path %>

# receive props
<%= yield(:props) %>
# send props
<% provide(:props, value) %>

# create form with model
<%= form_with(model: @model, local: true) do |f| %>
  <%= f.label :value %>
  <%= f."type_field" :value %>
<% end %>
# create form without model
<%= form_with(url: pathName_path, scope: :controller, local: true) do |f| %>
  <%= f.label :value %>
  <%= f."type_field" :value %>
<% end %>
```

## Partial

it is HTML component. it can be reused in .erb files

- app/views/layouts/_partial.html.erb


# Controller

generate controllers
  - create app/controllers/Controller.rb
  - create app/views/controller/action/html.erb
  - create test/controllers/Controller_text.rb
  - create app/helpers/Controller_helper.rb
  - create app/assets/javascripts/Controller.coffee
  - create app/assets/stylesheets/Controller.scss
  - route get '*'
```ruby
# controller
rails generate controller "Controllers_name" "actions"
# remove
rails destroy controller "Controllers_name" "actions"
```


## Helper

it is helper `function`. it can be reused in every .rb or .erb files

- app/controllers/helpers/*_helper.rb


# Model

it is a Class Object.

generate model. it automatically generate "created_at" and "updated_at" fields
  - create db/migrate/*.models.rb
  - create app/models/model.rb
  - create test/models/model_test.rb
  - create test/fixtures/models.yml
```ruby
# model
rails generate model "Model_name" "column:type"
# create sub table
rails generate model "Model_name" "column:type" "parent_table:references"
# remove
rails destroy model "Model_name"
```

rails db
```ruby
# create database
rails db:create
# create table from model
rails db:migrate
rails db:migrate RAILS_ENV=production # migrate into production env
# drop database
rails db:drop
# drop table
rails db:rollback
# drop and create database
rails db:reset
# fields reset
rails db:migrate:reset
# restore init version
rails db:migrate VERSION=0
# migrate schema
rails generate migration "migrateName_models" "column:type"
# insert seed from db/seeds.rb
rails db:seed
```



## ORM(Object Relational Mapping)

Rails's ORM is `Active Record`. 

- model = class(db/migrate/model.rb) named singular with capitalized first letter
- teble = schema(db/migrate/schema.rb) named plural words

- types
  - :binary
  - :boolean
  - :date
  - :datetime
  - :decimal
  - :float
  - :integer
  - :primary_key
  - :string
  - :text
  - :time
  - :timestamp

create
```ruby
field1 = Model.new do |f|
  f.column1 = value1
  f.column2 = value2
end
field1.save
# below is same
field1 = Model.create(column1: value1, column2: value2)
```
read
```ruby
# full-table scan
Model.all
# get first field
Model.first
# get last field
Model.last
# get by column
Model.find_by(column: value)
# WHERE, ORDER, LIMIT
Model.where(column: value).order(column: :desc).limit(n)
```
update
```ruby
field = Model.find_by(column: value)
field.update(column: new_value)
```
delete
```ruby
# delete single field
Model.destroy_by(column: value)
# delete all fields
Model.destroy_all
```

## constraints

below are validation key and value
  - presence: true or false = NOT NULL
  - uniqueness: true or false, { case_sensitive: false } = UNIQUE
  - length: { maximum: x, minimum: y, message: "error message" }
  - format: { with: ReExpression, message: "error message" }
```ruby:app/models/model.rb
  validates :column, key: value
```
```ruby:rails console
  f = Model.new({})
  f.valid? # true or false
  f.errors.full_messages # return error messages
```

## other

```shell:rails console
# return the number of fields
Model.count
```

## encrypt password

install bcrypt

```shell:Gemfile
gem 'bcrypt' '3.1.13'
# install on shell
bundle install
```

enable has_secure_password in model.rb.
it make "password_digest" column into schema.rb.
user should put "password" and "password_confirmation" values

```rb:app/models/model.rb
  has_secure_password
```

```shell:rails console
user = User.find_by(*)
user.authenticate("password") # return instance or false
```



# Test

write test/

- methods
  - assert(test, [msg]): ensures that test is true
  - assert_not(test, [msg]): ensures that test is false
  - assert_equal(expected, actual, [msg]): ensures that expected == actual is true
  - assert_empty(obj, [msg]): ensures that obj is empty?
  - assert_match(regexp, string, [msg]): ensures that a string matched the regular expression
  
  - assert_no_difference(expression) do: asserts that the numeric result of evaluating an expression is not changed before and after invoking the passed in block


make test colorful
```ruby
# make test code color GREEN or RED
require 'minitest/reporters'
Minitest::Reporters.use!
```

## Integration test

```ruby
# create test file
rails generate integration_test "test_name"
# run test code
rails test:integration
```

## fixture

it is test data into db

- test/fuxtures/models.yml

## Guard(test automation)

```ruby
# initialize
bundle exec guard init
# run
bundle exec guard
```

## add RSpec

you have to load only once on your computer
```shell
gem install rspec
```

add package
```Gemfile
group :development, :test do
  gem 'rspec-rails', ">= 3.9.0"
end
```

```shell
bundle install
bin/rails generate rspec:install
# bin/rails webpacker:install
  
rails db:migrate db:test:prepare
```

so far, when you generate model rails also create spec/models

run
```shell
bundle exec rspec
```
  
# Rails Commands

```ruby
# generate controllers or model
rails generate
# run testing
rails test
# exec irb on rails
rails console
rails console --sandbox # don't change db
rails console production # run in production env
# run puma
rails server
rails server --environment production # run puma in production env
```

config Cloud9 connection
```ruby
# config/environment/development.rb
  # allow to connect with Cloud9
  config.hosts.clear
```

## environment

1. development
2. test
3. production

activate ssl
```rb:config/environments/production.rb
  config.force_ssl = true
```


# Heroku commands

you need to push after merge temporary branch to master branch, when you work in another branch but master

create Procfile
```shell:./Procfile
web: bundle exec puma -C config/puma.rb
```

```ruby
# login
heroku login --interactive # don't open browser
# create app
heroku create "APP_NAME"
# rename
heroku raname "NEW_APP_NAME"
# push
git push heroku master
# log
heroku logs
```


