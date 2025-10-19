ETL process

1.Total revenue from all orders

select sum(amount) as tot_revenue from payments;

2.Revenue by item

select i.item_name,sum(oi.price * oi.quantity) as revenue_by_item from items i join order_items oi on oi.item_id = i.item_id group by i.item_name;

3.Revenue by payment methods

select payment_method, amount from payments;

4.Total revenue by DATE

 select date(paid_at) as Date,sum(amount) as tot_amount from payments group by date(paid_at);

5.Total orders and Revenue by Customers

SELECT 
    c.first_name,
    c.last_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM 
    customers c
JOIN 
    orders o ON o.user_id = c.user_id
JOIN 
    order_items oi ON oi.order_id = o.order_id
GROUP BY 
    c.user_id;

6.Items ordered by category

select i.item_name,c.category_name,sum(oi.quantity) from categories c join items  i on i.category_id = c.category_id join order_items oi on oi.item_id = i.item_id group by i.item_name,c.category_name;

7.orders by payment status

select p.payment_status, count(o.order_id) as Orders from payments p join orders o on p.order_id = o.order_id group by o.order_id,p.payment_status;

8.user with most orders

 select c.first_name,c.last_name, count(o.order_id) tot_orders from customers c join orders o on c.user_id = o.user_id group by o.user_id order by tot_orders  limit 5;

9.Revenue by category

 select c.category_name,sum(oi.quantity * oi.price) as tot_revenue from categories c join items i on i.category_id = c.category_id join order_items oi on oi.item_id = i.item_id group by c.category_name;

10.customer deatils with orders

SELECT 
    c.first_name,
    c.last_name,
    c.email,
    i.item_name,
    o.order_id
FROM 
    customers c
JOIN 
    orders o ON c.user_id = o.user_id
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    items i ON oi.item_id = i.item_id;
