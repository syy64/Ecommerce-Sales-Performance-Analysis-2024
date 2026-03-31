create database ecommerse;
select * from ecommerce_10000;
# clean dataset 
ALTER table ecommerce_10000 rename column ÿOrderID to OrderId;
describe ecommerce_10000;
alter table ecommerce_10000 modify column orderdate date;
# finding KPIs
-- What is the total number of transactions? 
create view `Total Transactions` as select distinct(count(orderid)) as `total transactions` from ecommerce_10000;
select * from `Total Transactions`;
-- What is the total revenue generated?
create view `Total Revenue` as select round(sum(totalamount)) as `total revenue` from ecommerce_10000;
select * from `Total Revenue`;
-- What is the average item price? 
create view `Avg item price` as select round(avg(price)) as `average item price` from ecommerce_10000;
select * from `Avg item price`;
-- What is the average quantity per order? 
create view `Avg quant. per order` as select round(avg(quantity)) as `average quantity per order` from ecommerce_10000;
select * from `Avg quant. per order`;
-- What is the average customer rating? 
create view `Avg customer rating` as select round(avg(rating)) as `average customer rating` from ecommerce_10000;
select * from `Avg customer rating`;
-- What is the total number of reviews? 
create view `Total no. of Reviwes` as select sum(reviews) as `total number of reviews` from ecommerce_10000;
select * from `Total no. of Reviwes`;


select * from ecommerce_10000;
#time-based performance
-- How does revenue vary by day of the week? 
create view `Revenue by day` as select dayname(orderdate) as day_of_week, round(sum(totalamount)) as `Total revenue` from ecommerce_10000 group by dayname(orderdate), 
dayofweek(orderdate) order by dayofweek(orderdate) asc;
select * from `Revenue by day`;
--  How does revenue change across months? 
create view `Revenue across month` as select monthname(orderdate) as monthh, round(sum(totalamount)) as `Total revenue` from ecommerce_10000
group by monthh order by `Total revenue` desc;
select * from `Revenue across month`;
--  Are there observable seasonal or cyclical patterns?
create view `Quarterly trends` as select quarter(orderdate) as quarterr, round(sum(totalamount)) 
as `Total revenue` from ecommerce_10000 group by quarterr order by quarterr;
select * from `Quarterly trends`;
create view `peak sales product in Q3` as select product, round(sum(totalamount)) as `Total revenue` 
from ecommerce_10000 where quarter(OrderDate) = 3 group by product order by `Total revenue` desc;
select * from `peak sales product in Q3`;
select * from ecommerce_10000;

-- Which products generate the highest revenue? 
create view `High selling products` as select product, round(sum(totalamount)) as `Total revenue` from ecommerce_10000 group by product order by `total revenue` desc;
select * from `High selling products`;
create view `Peak categories` as select category, round(sum(totalamount)) as `Total revenue` from ecommerce_10000 group by category order by `total revenue` desc;
select * from `Peak categories`;
-- Which categories and brands perform best?
create view `Top-selling brands` as select brand, round(sum(totalamount)) as `Total revenue` from ecommerce_10000 group by brand order by `total revenue` desc;
select * from `Top-selling brands`;
-- Which cities contribute the most to revenue? 
create view `Top cities` as select city, round(sum(totalamount)) as `Total revenue` from ecommerce_10000 group by city order by `total revenue` desc;
select * from `Top cities`;
-- Are there differences in performance across platforms (Amazon, Jumia, Souq)?
create view `Performance across platforms` as select platform, round(sum(totalamount)) as `Total revenue` from ecommerce_10000 group by platform order by `total revenue` desc;
select * from `Performance across platforms`;

select * from ecommerce_10000;
-- checking if certain price rnages drive more sales?
select max(price), min(price) from ecommerce_10000;
select case when price < 9000 then 'Low' when price between 9000 and 12000 then 'Mid'
else 'High' end as `price range`, round(sum(totalamount)) as `Total revenue` from ecommerce_10000 
group by `price range` order by `Total revenue`desc;

-- see if high rated products drive more sales
select rating, round(sum(totalamount)) as `Total revenue` from ecommerce_10000 group by rating order by `Total revenue` desc;


