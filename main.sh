sed -n -i  '/CREATE TABLE/,/PRIMARY KEY CLUSTER/p' scripts/*.sql
sed -i '$d' scripts/*.sql
sed -i '$s/,//g ; $s/$/)/g' scripts/*.sql
sed -i 's/\[//g;s/\]//g' scripts/*.sql
sed -i 's/dbo.//g' scripts/*.sql
sed -i "s/'0'/0/g" scripts/*.sql
sed -i "s/nvarchar(max)/text/g" scripts/*.sql

rm patstat.db

for x in $(ls scripts/*.sql)
do
	echo "loading $x"
	sqlite3 patstat.db < $x
done

./combine_data.sh

sqlite3 patstat.db < insert_data.sql
