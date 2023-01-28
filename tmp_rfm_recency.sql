 with 
 orders_closed as (
			select
				user_id,
				(date_trunc('day', order_ts)::DATE) as order_dt
			from analysis.orders o
			where (date_trunc('day', order_ts)::DATE) >= '2022-01-01' and
					status = (select id from analysis.orderstatuses where key = 'Closed')),
user_last_order as (
			select
				user_id,
				max(order_dt) as last_order_dt
			from orders_closed
			group by user_id),			
all_users_last_order as (
			select
				users.id,
				user_last_order.last_order_dt
			from analysis.users
			left join user_last_order
			on users.id = user_last_order.user_id),
sorted as (
			select
				id,
				ROW_NUMBER() OVER(ORDER BY last_order_dt asc) num
			from all_users_last_order)
insert into analysis.tmp_rfm_recency 
select
	id as user_id,
	case 
		when num > 0 and num <= 200 then 5
		when num > 200 and num <= 400 then 4
		when num > 400 and num <= 600 then 3
		when num > 600 and num <= 800 then 2
		when num > 800 and num <= 1000 then 1
	end as recency 
from sorted