-- Display order id and product name from the join of order, is_a and products
select order_id,product_name from (_order natural join is_a) natural join products;

-- Displays the total price corresponding to each order.
UPDATE cart c SET total_price = (SELECT sum(price) from (includes natural join products) a group by a.cart_id having a.cart_id = c.cart_id);

-- Deleting a supplier deletes the products supplied by them --
alter table products drop constraint products_supplier_id_fkey;

alter table products add constraint products_supplier_id_fkey foreign key(supplier_id) references supplier on delete cascade;

-- Displays the Customer ID and Order ID of the customers who have successfully mad payment through cash --
select payment_id,order_id,customer_id from cash natural join _order where paid_status='T';

select product_name, brand_name from products natural join supplier;

-- Displays the order ID and number of products with the corresponding order
select order_id,count(product_id) as #OfProducts from is_a group by order_id;

-- Displays the customer ID and City of the customer who have orders in the same city
select c.customer_id,c.city from customer c, _order o where o.customer_id=c.customer_id and c.city=o.city; 

-- Display number of order each customer has along with Customer name.
select c.customer_id,count(*) from _order o, customer c where o.customer_id=c.customer_id group by c.customer_id;


-- Display the product ID and Product name from product table where stock <50
select product_id,product_name from products where stock<50;

CREATE VIEW view1 AS SELECT a.customer_name, b.contact_no FROM customer a CROSS JOIN customer_contact b WHERE a.customer_id=b.customer_id;

CREATE VIEW view2 AS SELECT customer_name FROM customer WHERE customer_id IN ( SELECT customer_id FROM customer_contact GROUP BY customer_id HAVING count(*)>2 );

-- Contact_no of SHIPPER
CREATE VIEW view3 AS (SELECT sc.contact_no FROM shipper_contact sc WHERE shipper_id IN ( SELECT o.shipper_id FROM _order o WHERE o.customer_id='C_001' ));

-- Number of Customers who have made the payment through cash;
CREATE VIEW view4 AS (SELECT count(*) FROM customer c WHERE c.customer_id IN ( SELECT o.customer_id FROM _order o WHERE o.order_id IN ( SELECT ca.order_id FROM cash ca WHERE ca.paid_status='t' )));
