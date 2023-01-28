 with 
 orders_closed as (
			select
				user_id,
				payment
			from analysis.orders o
			where (date_trunc('day', order_ts)::DATE) >= '2022-01-01' and
					status = (select id from analysis.orderstatuses where key = 'Closed')),
user_order_sum as (
			select
				user_id,
				sum(payment) as order_sum
			from orders_closed
			group by user_id),
all_users_order_sum as (
			select
				users.id,
				case
					when user_order_sum.order_sum is null then 0
					else user_order_sum.order_sum
				end as all_users_order_add
			from analysis.users
			left join user_order_sum
			on users.id = user_order_sum.user_id),
sorted as (
	select
			id,
			ROW_NUMBER() OVER(ORDER BY all_users_order_add desc) num
	from all_users_order_sum)
insert into analysis.tmp_rfm_monetary_value 
select
	id as user_id,
	case 
		when num > 0 and num <= 200 then 5
		when num > 200 and num <= 400 then 4
		when num > 400 and num <= 600 then 3
		when num > 600 and num <= 800 then 2
		when num > 800 and num <= 1000 then 1
	end as monetary_value 
from sorted
