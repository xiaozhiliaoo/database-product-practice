# http://ronaldbradford.com/blog/mysql-dml-stats-per-table-2009-09-09/
mysqlbinlog /path/to/mysql-bin.000999 | \
grep -i -e "^update" -e "^insert" -e "^delete" -e "^replace" -e "^alter" | \
cut -c1-100 | tr '[A-Z]' '[a-z]' | \
sed -e "s/\t/ /g;s/'//g;s/(.*$//;s/ set .*$//;s/ as .*$//" | \
sed -e "s/ where .*$//" | \
sort | uniq -c | sort -nr