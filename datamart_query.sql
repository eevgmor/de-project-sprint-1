insert into analysis.dm_rfm_segments
select 
	u.id as user_id,
	recency,
	frequency,
	monetary_value
from analysis.users u
join analysis.tmp_rfm_recency trr on u.id = trr.user_id
join analysis.tmp_rfm_frequency trf on u.id = trf.user_id
join analysis.tmp_rfm_monetary_value trmv on u.id = trmv.user_id
order by user_id asc;

user_id|recency|frequency|monetary_value|
-------+-------+---------+--------------+
      0|      1|        3|             4|
      1|      4|        3|             3|
      2|      2|        3|             5|
      3|      2|        3|             3|
      4|      4|        3|             3|
      5|      4|        5|             5|
      6|      1|        3|             5|
      7|      4|        2|             2|
      8|      1|        1|             3|
      9|      1|        3|             2|
