create table if not EXISTS users(
  	user_id serial primary key,
	birth_date DATE,
	sex varchar(6),
	age int);

create TABLE if not exists orders(
	item_id serial primary key,
	description varchar(60), 
	price decimal(10,2),
	category varchar(100) 

);

CREATE TABLE IF  NOT EXISTS ratings(
  	rating_id int PRIMARY KEY,
  	item_id int,
  	user_id int,
  	review varchar(200),
    rating NUMERIC(5,2),
	FOREIGN KEY (item_id) REFERENCES orders (item_id),
  	FOREIGN KEY (user_id) REFERENCES users (user_id)
);


INSERT INTO users (birth_date, sex, age)
SELECT 
    (date '2005-01-01' - (random() * (interval '15 years'))::interval)::date as birth_date,
    CASE WHEN RANDOM() < 0.5 THEN 'Male' ELSE 'Female' END as sex,
    EXTRACT(YEAR FROM age((date '2005-01-01' - (random() * (interval '15 years'))::interval)::date))::INT as age
FROM generate_series(1, 20);


INSERT INTO orders (description, price, category)
SELECT 
    'Description ' || i,
    ROUND((10 + (RANDOM() * 990))::numeric, 2) as price,
    'Category ' || (i%5 + 1) as category
FROM generate_series(1, 20) as i;


INSERT INTO ratings (rating_id, item_id, user_id, review, rating)
SELECT 
    ROW_NUMBER() OVER () AS rating_id,
    o.item_id,
    u.user_id,
    'Review ' || ROW_NUMBER() OVER (),
    ROUND((RANDOM() * 5)::NUMERIC + 1, 2)
FROM users u, orders o
LIMIT 20;



