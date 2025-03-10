# README

<b>Setup the project:</b>
1. Clone the repository:
   
    git clone https://github.com/ab00zar/ReedsyShop.git

   cd ReedsyShop
   
2. Install dependencies:
   
    bundle install
   
3. Database setup:

    rails db:create

    rails db:migrate

4. Seed the database:

   rails db:seed

 5. Run the server:

    Rails server

  6. Run the tests:
   
     rspec spec/
    


<br><br>

<b>Description of API Endpoints with cURL Examples:</b>

- List Products (```GET /api/v1/products```)

  Description: Retrieves a list of all products in the store.
  
  cURL Example:
  
  ```curl http://localhost:3000/api/v1/products```

* Update Product Price (```PUT /api/v1/products?code=<code>```)

   Description: Update the price of a specific product<br>
   Parameters:<br>
   code: The product code (e.g., MUG)<br>
   price: The new price<br>
  ```curl -X PUT -H "Content-Type: application/json" -d '{"price": 7.50}' http://localhost:3000/api/v1/products?code=MUG```
  <br>
+ Calculate Total Price (```GET /api/v1/carts/total_price?items=...```)<br>
  Description: Calculates the total price of a list of items.<br>
  Parameters:
  items: A comma-separated list of item codes and quantities (e.g., 1 MUG,2 TSHIRT).<br>
  ```curl "http://localhost:3000/api/v1/carts/total_price?items=1%20MUG,2%20TSHIRT,1%20HOODIE"```<br>
