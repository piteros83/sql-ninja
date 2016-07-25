--select * from user_segments

--moving tables
SELECT  'ALTER TABLE &SCHEMAT.'||segment_name||' MOVE TABLESPACE &TARGET_SPACE ;'from user_segments where  segment_type='TABLE' AND tablespace_name='&SOURCE_SPACE';
--SELECT  SUM(BYTES)/1024/1024 from user_segments where  segment_type='TABLE' AND tablespace_name='TABLESPACE_NAME';

--moving  indexes
SELECT  'ALTER INDEX &SCHEMAT.'||segment_name||' REBUILD TABLESPACE &TARGET_SPACE ;'from user_segments where  (segment_type='INDEX' ) AND tablespace_name='&SOURCE_SPACE';
--SELECT   SUM(BYTES)/1024/1024 from user_segments where  (segment_type='INDEX' ) AND tablespace_name='TABLESPACE_NAME';


--moving partition
SELECT  'ALTER TABLE &SCHEMAT.'||segment_name||' MOVE PARTITION '||partition_name ||' TABLESPACE &TARGET_SPACE ;' from user_segments where  segment_type='TABLE PARTITION' AND tablespace_name='&SOURCE_SPACE';
--SELECT  SUM(BYTES)/1024/1024  from user_segments where  segment_type='TABLE PARTITION' AND tablespace_name='TABLESPACE_NAME';

--moving partition indexes
SELECT  'ALTER INDEX &SCHEMAT.'||segment_name||' REBUILD partition '|| partition_name||' TABLESPACE &TARGET_SPACE ;' from user_segments where (segment_type='INDEX PARTITION' ) AND tablespace_name='&SOURCE_SPACE';
--SELECT  SUM(BYTES)/1024/1024  from user_segments where (segment_type='INDEX PARTITION' ) AND tablespace_name='TABLESPACE_NAME';

