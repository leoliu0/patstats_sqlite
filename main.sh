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

CREATE INDEX IX_tls201_appln_dat ON tls201_appln(appln_filing_date);
CREATE INDEX IX_tls201_appln_internat ON tls201_appln(internat_appln_id);
CREATE INDEX IX_tls201_appln_nr ON tls201_appln(appln_auth, appln_nr, appln_kind);
CREATE INDEX IX_tls204_prior_appln_id ON tls204_appln_prior(prior_appln_id);
CREATE INDEX IX_tls206_person_cty ON tls206_person(person_ctry_code);
CREATE INDEX IX_tls207_pers_appln_id ON tls207_pers_appln(appln_id);
CREATE INDEX IX_tls207_pers_appln_pers_id ON tls207_pers_appln(person_id);
CREATE INDEX tls209_appl_ipc_XLS209M1 ON tls209_appln_ipc(ipc_class_symbol);
CREATE INDEX tls211_pat_publn_XLS211M2 ON tls211_pat_publn(publn_auth, publn_nr, publn_kind);
CREATE INDEX tls211_pat_publn_XLS211M3 ON tls211_pat_publn(appln_id);
CREATE INDEX tls211_pat_publn_XLS211M4 ON tls211_pat_publn(publn_date);
CREATE INDEX tls212_citation_XLS212C2 ON tls212_citation(cited_pat_publn_id);
CREATE INDEX tls212_citation_XLS212C3 ON tls212_citation(cited_appln_id, pat_publn_id);
CREATE INDEX tls222_appln_jp_class_XLS222C1 ON tls222_appln_jp_class(jp_class_symbol, jp_class_scheme);
CREATE INDEX tls223_appln_docus_XLS223C1 ON tls223_appln_docus(docus_class_symbol);
CREATE INDEX IX_tls226_person_id ON tls226_person_orig(person_id);
CREATE INDEX IX_tls227_pers_publn_id ON tls227_pers_publn(pat_publn_id);
CREATE INDEX IX_tls227_pers_publn_pers_id ON tls227_pers_publn(person_id);
