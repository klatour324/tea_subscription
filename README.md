# Tea Subscription Service

## About this Project
- This is a rails application that provides RESTful API endpoints for frontend plug in with this Tea Subscription Service.


## Table of Contents

  - [Getting Started](#getting-started)
  - [Prerequisites](#Prerequisites)
  - [Running the tests](#running-the-tests)
  - [Database Schema](#database-schema)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
  - [Versioning](#versioning)
  - [Author](#author)


## Getting Started

1. Please fork and Clone this repo using the following command:
`$ git clone <your@github.account/tea_subscription>`

2. Run bundle install:
`$ bundle install`

3. Setup the database:
`$ rails db:{create,migrate,seed}`

### Prerequisites

To run this application you will need Ruby 2.5.3 and Rails 6.1.3.2

## Running the tests
RSpec testing suite is utilized for testing this application.
- Run the RSpec suite to ensure everything is passing as expected  
`bundle exec rspec spec/`

## Database Schema
The schema represents the relationships between the models in the database. The schema includes the following three tables:
![Screen Shot 2021-06-01 at 4 56 24 PM](https://user-images.githubusercontent.com/23460878/120395274-59d9f180-c2fa-11eb-9661-6a6091bb6f3a.png)


## Endpoints
### tea_subscription API Contract  

| HTTP verbs | Paths  | Used for | Output |
| ---------- | ------ | -------- | ------:|
| POST | /api/v1/customers | Create a new customer | [json](#create-a-customer) |
| POST | /api/v1/teas | Create a new tea | [json](#create-a-tea) |
| POST | /api/v1/customers/:customer_id/subscriptions | Subscribe a Customer to a Tea | [json](#subscribe-a-customer-to-a-tea) |
| PATCH | /api/v1/customers/:customer_id/subscriptions/:id | Cancel a customer's tea subscription | [json](#cancel-a-customer's-tea-subscription) |
| GET | /api/v1/customers/:customer_id/subscriptions | Get all of a customer's subscriptions(active and cancelled) | [json](#get-all-subscription) |

## JSON Responses
​
## Create a Customer
`POST /api/v1/customers`
  ```json
  {
    "data": {
              "id": "4",
              "type": "customer",
              "attributes": {
                "first_name": "Joe",
                "last_name": "Shmoe",
                "email": "whatever@example.com",
                "street_address": "123 Peach St.",
                "city": "Denver",
                "state": "CO",
                "zipcode": "80110"
              }
          }    
  }
  ```

## Built With
- Ruby
- Rails
- RSpec
- FactoryBot
- Faker

## Versioning
- Ruby 2.5.3
- Rails 6.1.3.2
- RSpec 3.10.0

## Author
- **Katy La Tour**
     | [GitHub](https://github.com/klatour324) |
    [LinkedIn](https://www.linkedin.com/in/klatour324/)
