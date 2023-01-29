 with 
 orders_closed as (
			select
				user_id
			from analysis.orders o
			where (date_trunc('day', order_ts)::DATE) >= '2022-01-01' and
					status = (select id from analysis.orderstatuses where key = 'Closed')),
user_order_count as (
			select
				user_id,
				count(user_id) as order_count
			from orders_closed
			group by user_id),
all_users_order_count as (			
			select
				users.id,
				case
					when user_order_count.order_count is null then 0
					else user_order_count.order_count
				end as all_users_order_sum
			from analysis.users
			left join user_order_count
			on users.id = user_order_count.user_id)
insert into analysis.tmp_rfm_frequency
select
	id,
	NTILE(5) OVER(ORDER BY all_users_order_sum asc) frequency
from all_users_order_count
