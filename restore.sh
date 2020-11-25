echo Starting restoration of database...

docker exec oracle_xe bash -c "
echo Closing database...
echo 'shutdown immediate;' | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus sys/oracle as sysdba 
"

echo Shotdown complete

docker cp ./backup/XE/ oracle_xe:/u01/app/oracle/oradata/

docker cp ./backup/onlinelog/ oracle_xe:/u01/app/oracle/fast_recovery_area/XE/

echo Restoration finished

echo Restarting database system...

docker exec oracle_xe bash -c "
echo 'startup;' | /u01/app/oracle/product/11.2.0/xe/bin/sqlplus sys/oracle as sysdba
echo Finishing database restart...
"

echo Database working