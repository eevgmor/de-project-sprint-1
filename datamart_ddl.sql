CREATE TABLE analysis.dm_rfm_segments (
	user_id int4 NOT NULL,
	recency int NOT NULL,
	frequency int NOT NULL,
	monetary_value int NOT null,
	CONSTRAINT dm_rfm_segments_pkey PRIMARY KEY(user_id)