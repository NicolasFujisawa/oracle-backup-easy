echo Starting database backup offline...

docker exec oracle_xe bash -c "
echo Closing database...
echo 'shutdown immediate;' | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus sys/oracle as sysdba 
"

echo Shotdown complete

docker cp oracle_xe:/u01/app/oracle/fast_recovery_area/XE/onlinelog/ ${PWD}/backup/

docker cp oracle_xe:/u01/app/oracle/oradata/XE/ ${PWD}/backup/

echo Database saved in ${PWD}/backup/

echo Restarting database system...

docker exec oracle_xe bash -c "
echo 'startup;' | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus sys/oracle as sysdba
echo Finishing database restart...
"

echo Database working