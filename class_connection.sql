--create user
CREATE USER C##uw_plsqlauca IDENTIFIED BY auca;
GRANT ALL PRIVILEGES TO C##uw_plsqlauca;

--create pdb
SHOW con_name;
ALTER SESSION SET container = CDB$ROOT;
CREATE PLUGGABLE DATABASE uw_to_delete_pdb
ADMIN USER uw_plsqlauca IDENTIFIED BY auca
FILE_NAME_CONVERT = ('C:\ORACLEXE\ORADATA\ORCL\PDBSEED\', 'C:\ORACLEXE\ORADATA\ORCL\PDBSEED\uw_to_delete_pdb\');

--after creation this is how you connecto to pdb
ALTER SESSION SET CONTAINER = CDB$ROOT;
CONNECT SYS/123@localhost:1521/orcl.mshome.net AS SYSDBA;
ALTER PLUGGABLE DATABASE uw_to_delete_pdb OPEN;
ALTER SESSION SET CONTAINER = uw_to_delete_pdb;
ALTER SESSION SET CONTAINER = uw_to_delete_pdb;

----delete pdb
CONNECT SYS/123 AS SYSDBA;
ALTER SESSION SET CONTAINER = CDB$ROOT;
ALTER PLUGGABLE DATABASE uw_to_delete_pdb CLOSE IMMEDIATE;
DROP PLUGGABLE DATABASE uw_to_delete_pdb INCLUDING DATAFILES;
SELECT con_id, name, open_mode FROM v$containers;