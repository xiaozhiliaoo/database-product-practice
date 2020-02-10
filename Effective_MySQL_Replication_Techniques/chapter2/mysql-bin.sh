MYCNF="/etc/my.cnf"
BINLOG='grep log-bin ${MYCNF} | cut -d'=' -f2'
echo ${BINLOG}
DIR='dirname ${BINLOG}'
cd ${DIR}
ls -lh *
cat *.index