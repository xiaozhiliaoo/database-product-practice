## install mysql master-slave in win10 use mysql-8.0.18-winx64.zip
### step1: install and start master cmd:

mysqld --initialize --console

root@localhost: 3ykwuhhk4Q)V

mysqld --install MYSQLMaster

net start MYSQLMaster

mysql -uroot -P3307 -p

alter user 'root'@'localhost' identified by '123456';

flush privileges;
 
quit;

mysql -uroot -P3307 -p123456
 
create user 'lili'@'%' identified by '123456'; --这样不行，因为slave连接的时候，
show slave status时候，会报错
Last_IO_Error: error connecting to master 'lili@localhost:3307' - retry-time: 60 retries: 10 message: Authentication plugin 'caching_sha2_password' reported error: Authentication requires secure connection.


CREATE USER 'lili'@'%' IDENTIFIED WITH 'mysql_native_password' BY '123456';
GRANT REPLICATION SLAVE ON *.* TO 'lili'@'%';

select user,host,plugin,authentication_string from mysql.user ;

grant replication slave on *.* to 'lili'@'%';

flush privileges;

-- note: https://dev.mysql.com/doc/refman/8.0/en/grant.html

### step2 install and start slave1 cmd:

mysqld --initialize --console

root@localhost: FfzR#gfI5KCs

mysqld --install MYSQLSlave1

net start MYSQLSlave1

mysql -uroot -P3308 -p;

alter user 'root'@'localhost' identified by '123456';

flush privileges;

change master to master_host='localhost',master_user='lili',master_password='123456',master_port=3307,master_log_file='mysql-bin.000002',master_log_pos=1344;

start slave;

show slave status \G;

stop slave;

### step3 install and start slave2 cmd:

mysqld --initialize --console

mysqld --install MYSQLSlave2

net start MYSQLSlave2;  --服务名是MYSQLSlave2; 注意;号

mysql -uroot -P3309 -p

alter user 'root'@'localhost' identified by '123456';

flush privileges;

change master to master_host='localhost',master_user='lili',master_password='123456',master_port=3307,master_log_file='mysql-bin.000002',master_log_pos=1344;

start slave;

show slave status \G;

stop slave;


#### Reference: 

https://www.cnblogs.com/liuliuyan/p/10945398.html

https://blog.csdn.net/wawa8899/article/details/86689618
