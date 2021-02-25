# Little Esty Shop

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
