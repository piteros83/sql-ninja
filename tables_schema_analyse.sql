--

--select * from dba_segments where owner='SCHEMA NAME'
--select * from user_tablespaces
--select * from user_ustats
--select * from user_tables 
--select * from user_tab_subpartitions
--select * from user_tab_stats_history 
--select * from user_tables
--select table_name,count(column_name) from user_tab_columns group by table_name
--select * from user_tab_columns;
--select * from user_tables;

--select table_name,tablespace_name,pct_free,compression from user_tables; -- pct_free compression
--select table_name,count(column_name) from user_tab_columns group by table_name; -- coll number
/*select segment_name,tablespace_name,sum(bytes)/1024/1024 as MB, sum(extents) from user_segments group by segment_name,tablespace_name;
select tablespace_name,owner,segment_name,bytes_sum/1024/1024,extents_sum from sitescope.pit_extents_count where owner='SCHEMA NAME'
and segment_count=1 and bytes_sum>100000000 and time_id=6360;
*/


select b.segment_name,b.tablespace_name,b.MB,b.partition_sum,a.col_num,c.pct_free,c.compression from
(select table_name,count(column_name) as col_num from user_tab_columns group by table_name) a,
(select segment_name,tablespace_name,segment_type,trunc(sum(bytes)/1024/1024) as MB, count(*) as partition_sum from user_segments group by segment_name,tablespace_name,segment_type) b,
(select table_name,tablespace_name,pct_free,compression from user_tables) c
 where b.MB>5000 and b.segment_type='TABLE' and a.table_name=b.segment_name and b.segment_name=c.table_name
 union
  select b.segment_name,b.tablespace_name,b.MB,b.partition_sum,a.col_num,c.pct_free,c.compression from
(select table_name,count(column_name) as col_num from user_tab_columns group by table_name) a,
(select segment_name,tablespace_name,segment_type,trunc(sum(bytes)/1024/1024) as MB, count(*) as partition_sum from user_segments group by segment_name,tablespace_name,segment_type) b,
(select distinct table_name,pct_free,compression from user_tab_partitions) c
 where b.MB>5000 and b.segment_type='TABLE PARTITION' and a.table_name=b.segment_name and b.segment_name=c.table_name;