--show what is going on in the database
SELECT sess.process, sess.status, sess.username, sess.schemaname, sql.sql_text
  FROM v$session sess,
       v$sql     sql
 WHERE sql.sql_id(+) = sess.sql_id
 
--sum all datafiles used by databases
select  sum(bytes)/1024/1024/1024 as GB, tablespace_name from dba_data_files group by tablespace_name