DROP TABLE IF EXISTS analysis.dm_rfm_segments;
CREATE TABLE IF NOT EXISTS analysis.dm_rfm_segments (
	user_id int4 NOT NULL,
	recency int NOT NULL CHECK ( recency between 1 and 5),
	frequency int NOT NULL CHECK ( frequency between 1 and 5),
	monetary_value int NOT null CHECK ( monetary_value between 1 and 5),
	CONSTRAINT dm_rfm_segments_pkey PRIMARY KEY(user_id));