# Little Esty Shop
*an ecommerce application for multiple vendors*
## Project Function (what it does)
  **Little Esty Shop** is an e-commerce rails web application that supports multiple merchants selling multiple items. There are both admin and merchant functionalities and statistics for the user.   

  There are built in data files for seed functionalities. See [#installation] for how to utilize on your local repository.
#### Admin Features
- Actions
  - Admin dashboard linking to 'admin/merchants' index and 'admininvoices' index
  - Access dashboard displaying statistics
  - Create a new merchant
  - Update merchant information
  - Enable or disable a merchant
  - Update an invoice status
- Analytics
  - Top merchants by revenue
  - Top 5 customers by successful transactions
  - Top merchant's best day

#### Merchant Features
- Actions
  - Access to merchant items and invoices
  - Update information on items
  - Enable or disable items
- Analytics
  - List of items ready to ship
  - Top 5 most popular items and highest selling date
  - Top 5 customers by successful transactions
  - Items organized by (enabled/disabled)

## Installation
- Fork this repository  
- Clone to local    
              `$  git clone <local_repo_name>`
- Install gems  
              `$  bundle install`
- Drop, create, and migrate the database  
              `$ rails db{:drop,:create,:migrate}`
- Load the seed data   
              `$ rails csv_load:all`

## Database Schema
The schema represents the relationships between the models in the database.
  - A Merchant can have many items.
  - A Merchant can have many customers, through invoice items. etc

![](schema_lil_esty_shop.png)

## Useage
- After installing, check that everything is functioning as expected. Run the rspec suite of tests.  
      `$ bundle exec rspec`
- To utlize this application, access either from local device  
      `$ rails s`
- Or access from the heroku application  
      `$ heroku open`

### Meta
**Authors:**  
Angel Breaux  | [github](https://github.com/abreaux26) | [linkedin](https://www.linkedin.com/in/angel-breaux-6b4027153/)  
Andrew Johnston  | [github](https://github.com/avjohnston) | [linkedin]()   
Alex Schwartz  | [github](https://github.com/aschwartz1) | [linkedin](https://www.linkedin.com/in/alex-s-77659758/)   
Alexa Morales Smyth  | [github](https://github.com/amsmyth1) | [linkedin](https://www.linkedin.com/in/moralesalexa/)
_______________________________


## Turing Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Setup

This project requires Ruby 2.5.3.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)

## Evaluation

At the end of the project, you will be assessed based on [this Rubric](./doc/rubric.md)

