--drop all db objects
--##########################################################################################################
--first count them
select count(*) from user_objects;
--build the query to drop selected objects
select 'drop '||object_type||' '|| object_name||  DECODE(OBJECT_TYPE,'TABLE',' CASCADE CONSTRAINTS;',';')
from user_objects;
--show recyclebin content after drop
SELECT count(*) FROM RECYCLEBIN;
--purge recyclebin
PURGE RECYCLEBIN;
