CREATE OR REPLACE VIEW analysis.orders
AS SELECT 
	orders.order_id,
    orders.order_ts,
    orders.user_id,
    orders.bonus_payment,
    orders.payment,
    orders.cost,
    orders.bonus_grant,
    last_status.status
FROM production.orders
join (select 
		distinct order_id,
		LAST_VALUE(status_id) over(PARTITION BY order_id order by dttm 
			RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as status
		from production.OrderStatusLog) as last_status
on orders.order_id = last_status.order_id