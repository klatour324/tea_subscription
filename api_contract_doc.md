# Tea Subscription API Contract Documentation

## Endpoints
| HTTP verbs | Paths  | Used for | Output |
| ---------- | ------ | -------- | ------:|
| POST | /api/v1/customers | Create a new customer | [json](#create-a-customer) |
| POST | /api/v1/teas | Create a new tea | [json](#create-a-tea) |
| POST | /api/v1/customers/:customer_id/subscriptions | Subscribe a Customer to a Tea | [json](#subscribe-a-customer-to-a-tea) |
| PATCH | /api/v1/customers/:customer_id/subscriptions/:id | Cancel a customer's tea subscription | [json](#cancel-a-customer's-tea-subscription) |
| GET | /api/v1/customers/:customer_id/subscriptions | Get all of a customer's subscriptions(active and cancelled) | [json](#get-all-subscription) |
| ERROR | errors | Error handling for requests | [json](#error-handling) |

### Create a Customer
`POST /api/v1/customers`

The request creates a new customer record when given valid data.
* __Required__

  The following fields are required in the post body request in order to create a new customer. If any required fields are missing or include invalid data an error will be returned (see [error handling](#error-handling)).
  * first_name: string
  * last_name: string
  * email: string (must be a valid email format `customer@example.com`)
  * street_address: string
  * city: string
  * state: string
  * zipcode: string

  Example json request body
  ```json
  {
    "first_name": "Joe",
    "last_name": "Shmoe",
    "email": "whatever@example.com",
    "street_address": "123 Peach St.",
    "city": "Denver",
    "state": "CO",
    "zipcode": "80110"
  }
  ```

  Example json response
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

### Create a Tea
`POST /api/v1/teas`

The request creates a new tea record when given valid data.
* __Required__

  The following fields are required in post body request in order to create a new tea. If any required fields are missing or include invalid data an error will be returned (see [error handling](#error-handling)).
  * title: string
  * description: string
  * temperature: float (can be either an integer or float)
  * brew_time: string

* __Optional__

  Example json request body
  `POST /api/v1/teas`
  ```json
  {
    "title": "Yummy Tummy Tea Time",
    "description": "Soft, soothing  Earl Grey tea that's yummy in your tummy",
    "temperature": 198.1,
    "brew_time": "12 minutes"  
  }
  ```

  Example json response
  ```json
  {
    "data": {
      "id": "10",
      "type": "tea",
      "attributes": {
        "title": "Yummy Tummy Tea Time",
        "description": "Soft, soothing  Earl Grey tea that's yummy in your tummy",
        "temperature": "198.1",
        "brew_time": "12 minutes",
      }
    }
  }
```
### Create a Subscription
`POST /api/v1/customers/:customer_id/subscriptions`

The request creates a new tea subscription record for a specific customer when given valid data.
* __Required__

  The following fields are required in the route and the post body request in order to create a new tea subscription for a customer. If any required fields are missing or include invalid data an error will be returned (see [error handling](#error-handling)).
  * tea_id: id
  * customer_id: integer
  * price: float

* __Optional__
The following fields are optional, if not provided they will be stored as null
* title: string
* frequency: string(i.e. "Twice a month")

  Example json request body
  `POST /api/v1/customers/1/subscriptions`
  ```json
  {
    "tea_id": 1,
    "price": 49.99,
    "title": "Tea-A-Holic Weekly Subscription",
    "frequency": "Three times a week"  
  }
  ```

  Example json response
  ```json
  {
    "data": {
      "id": "1",
      "type": "customer_subscription",
      "attributes": {
        "tea_id": "1",
        "price": "49.99",
        "title": "Tea-A-Holic Weekly Subscription",
        "brew_time": "Three times a week",
      }
    }
  }
```

### Update a Customer's Subscription
`PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id`

The request updates an existing customer's subscription record when given valid data. Only the tea subscription records that are included in the request will be updated.
* __Required__

  The following fields are required in the route and post body request. If any required fields are missing or include invalid data an error will be returned (see [error handling](#error-handling)).
  * customer_id: integer
  * subscription_id: integer
  * status: string (accepted values are active or cancelled)

* __Optional__

  The following fields are optional, if not provided they will be stored as null
  * title: string
  * price: float
  * frequency: string(i.e. "Twice a month")

  Example json request body
  `PATCH /api/v1/customers/1/subscriptions/2`
  ```json
  {
    "title": "Mommy's Monthly Tea Fixin",
    "status": "cancelled",
    "price": 29.99,
    "frequency": "Once a month"
  }
```

  Example json response
  ```json
  {
    "data": {
      "id": "2",
      "type": "customer_subscription",
      "attributes": {
        "customer_id": "1",
        "title": "Mommy's Monthly Tea Fixin",
        "price": "29.99",
        "frequency": "Once a month",
        "status": "cancelled"
      }
    }        
  }
  ```

### Get all of a Customer's Subscriptions (Active & Cancelled)
`GET /api/v1/customers/:customer_id/subscriptions`
* __Required__

  The following fields are required in the route. If any required fields are missing or include invalid data an error will be returned (see [error handling](#error-handling)).
  * customer_id: integer

  Example HTTP Request
  `GET /api/v1/customers/4/subscriptions`

  Example json response
  ```json
  {
    "data": {
      "id": "1",
      "type": "customer_subscriptions",
      "attributes": {
        "subscriptions": [
          {
            "customer_id": "4",
            "title": "Mommy's Monthly Tea Fixin",
            "price": "29.99",
            "frequency": "Once a month",
            "status": "cancelled"  
          },
          {
            "customer_id": "4",
            "title": "Holiday Herbal Special",
            "price": "74.99",
            "frequency": "Once a year",
            "status": "cancelled"
          },
          {
            "customer_id": "4",
            "title": "Your Herbacious Home Remedy",
            "price": "24.99",
            "frequency": "Twice a month",
            "status": "active"
          }
        ]
      }
    }
  }
```


### Error Handling
### Sad Path Response (no data matches query)
* A sad path response is returned when no matching data can be found, such as when the customer search returns 0 results.

  ```json
    {
      "data": {}
    }
  ```

### Edge Case Response (invalid data parameters)
* An edge case error is returned when invalid data parameters are provided, such as invalid customer/subscription id, missing parameters, or invalid data for a parameter (i.e. empty string, blank, letter instead of integer, etc.).

  ```json
  {
    "message": "your request cannot be completed",
    "error": "error message",
    "url": ""
  }
  ```
