# patstats_sqlite
scripts to load patstats data to sqlite (versionless)

Requirements:
1. sqlite and sqlite shell installed
2. GNU sed

Steps:
1. Copy the SQL scripts to this directory (so that you have a scripts folder with MSSQL scripts provided by patstats)
2. Copy the Data/ directory (with all the unzipped text files) to this directory
3. run main.sh

You will have patstats.db in this directory if done correctly. The feature of this script is that it does not depend on patstat version (unless there are new table or deleted table, which should rarely happen)
