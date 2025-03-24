# README


<b>Description of the developed API Endpoints with cURL Examples:</b>

1. List Products (```GET /api/v1/products```)

  Description: Retrieves a list of all products in the store.
  
  cURL Example:
  
  ```curl http://localhost:3000/api/v1/products```

2. Update Product Price (```PUT /api/v1/products?code=<code>```)

   Description: Update the price of a specific product<br>
   Parameters:<br>
   code: The product code (e.g., MUG)<br>
   price: The new price<br>
  ```curl -X PUT -H "Content-Type: application/json" -d '{"price": 7.50}' http://localhost:3000/api/v1/products?code=MUG```
  <br>
3.  Calculate Total Price (```GET /api/v1/carts/total_price?items=...```)<br>
  Description: Calculates the total price of a list of items.<br>
  Parameters:
  items: A comma-separated list of item codes and quantities (e.g., 1 MUG,2 TSHIRT).<br>
  ```curl "http://localhost:3000/api/v1/carts/total_price?items=1%20MUG,2%20TSHIRT,1%20HOODIE"```<br>

  It considers these discounts and it's developed in way to make easy adding new discounts:
  
- 30% discounts on all `TSHIRT` items when buying 3 or more.
- Volume discount for `MUG` items:
  - 2% discount for 10 to 19 items
  - 4% discount for 20 to 29 items
  - 6% discount for 30 to 39 items
  - ... (and so forth with discounts increasing in steps of 2%)
  - 30% discount for 150 or more items


  Here are some examples on how discounts should work and the result should be presented:

```
Items: 1 MUG, 1 TSHIRT, 1 HOODIE
Total: 41.00
```

```
Items: 9 MUG, 1 TSHIRT
Total: 69.00
```

```
Items: 10 MUG, 1 TSHIRT
Total: 73.80

Explanation:
  - Total without discount: 60.00 + 15.00 = 75.00
  - Discount: 1.20 (2% discount on MUG)
  - Total: 75.00 - 1.20 = 73.80
```

```
Items: 45 MUG, 3 TSHIRT
Total: 279.90

Explanation:
  - Total without discount: 270.00 + 45.00 = 315.00
  - Discount: 21.60 (8% discount on MUG) + 13.50 (30% discount on TSHIRT) = 35.10
  - Total: 315.00 - 35.10 = 279.90
```

```
Items: 200 MUG, 4 TSHIRT, 1 HOODIE
Total: 902.00

Explanation:
  - Total without discount: 1200.00 + 60.00 + 20.00 = 1280.00
  - Discount: 360.00 (30% discount on MUG) + 18.00 (30% discount on TSHIRT) = 378.00
  - Total: 1280.00 - 378.00 = 902.00
```

<br><br>

<b>Setup the project:</b>
1. Clone the repository:
   
    ```git clone https://github.com/ab00zar/ReedsyShop.git```

   ```cd ReedsyShop```
   
2. Install dependencies:
   
    ```bundle install```
   
3. Database setup:

    ```rails db:create```

    ```rails db:migrate```

4. Seed the database:

   ```rails db:seed```

 5. Run the server:

    ```Rails server```

  6. Run the tests:
   
     ```rspec spec/```
