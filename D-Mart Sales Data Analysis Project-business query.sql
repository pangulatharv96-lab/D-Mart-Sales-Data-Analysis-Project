create database D_MART;
use  D_MART;  
select * from customer;

#Total count of dataset
select count(*) from customer;

#Aggreagation Calculation 
select sum(Price) from customer;
select max(Price) from customer;
select min(Price) from customer;
select avg(Price) from customer;

select sum(DiscountedPrice) from customer;
select max(DiscountedPrice) from customer;
select min(DiscountedPrice) from customer;
select avg(DiscountedPrice) from customer;

select count(distinct Brand) as total_brand
from customer ;

select *
from customer
where Price < 1000;

select sum(Price) from customer 
where Name='Society Tea'
limit 5;

select sum(Price) from customer 
group by Name
order by Name desc
limit 5;

select sum(Price * DiscountedPrice) as total_revenue
from customer;

select Name, Price
from customer
order by Price desc
limit 5;

select Category,
        sum(Price * DiscountedPrice) as total_sales
from customer
group by Category;
  
  
select Brand,
     avg(Price) as avg_price_brand
from customer
group by Brand;
     
# discount greater than 30%
SELECT name, price, discountedprice,
       ((price - discountedprice)/price)*100 AS discount_percent
FROM customer
WHERE ((price - discountedprice)/price)*100 > 30;

#category with highest revenue
SELECT category,
       SUM(price * quantity) AS revenue
FROM customer
GROUP BY category
ORDER BY revenue DESC
LIMIT 1;

#Rank products by price within each category
SELECT name, category, price,
       RANK() OVER (PARTITION BY category ORDER BY price DESC) AS price_rank
FROM customer;


#Find cumulative revenue
SELECT name,
       SUM(price * quantity) OVER (ORDER BY name) AS cumulative_revenue
FROM customer;

#Find products priced above category average
SELECT name, category, price
FROM customer p
WHERE price >
      (SELECT AVG(price)
       FROM customer
       WHERE category = p.category);
       
#Find percentage contribution of each category to total sales
SELECT category,
       SUM(price * quantity) * 100.0 /
       (SELECT SUM(price * quantity) FROM customer) AS revenue_percentage
FROM customer
GROUP BY category;

#How do you identify low-performing products?
SELECT name, SUM(quantity) AS total_sold
FROM customer
GROUP BY name
HAVING SUM(quantity) < 10;

#Which brands need discount optimization?
SELECT brand,
       AVG(((price - discountedprice)/price)*100) AS avg_discount
FROM customer
GROUP BY brand
ORDER BY avg_discount DESC;

#Find stock risk (high demand, low quantity)
SELECT name, quantity
FROM customer
WHERE quantity < 5
ORDER BY quantity ASC;

select Price,
case 
when Price < 500 then "low"
when Price < 1000 then "mid"
when Price < 2000 then "high"
else "Very_high"
end price_distribution
from customer;


