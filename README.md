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
![Screen Shot 2021-06-02 at 4 05 40 PM](https://user-images.githubusercontent.com/23460878/120585802-0948be00-c3f8-11eb-8284-45a60b72bf3d.png)


## Endpoints
### tea_subscription API Contract  

| HTTP verbs | Paths  | Used for | Output |
| ---------- | ------ | -------- | ------:|
| POST | /api/v1/customers | Create a new customer | [json](#create-a-customer) |
| POST | /api/v1/teas | Create a new tea | [json](#create-a-tea) |
| POST | /api/v1/customers/:customer_id/subscriptions | Subscribe a Customer to a Tea | [json](#subscribe-a-customer-to-a-tea) |
| PATCH | /api/v1/customers/:customer_id/subscriptions/:id | Cancel a customer's tea subscription | [json](#cancel-a-customer's-tea-subscription) |
| GET | /api/v1/customers/:customer_id/subscriptions | Get all of a customer's subscriptions(active and cancelled) | [json](#get-all-subscription) |
| ERROR | errors | Error handling for requests | [json](#error-handling) |


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
