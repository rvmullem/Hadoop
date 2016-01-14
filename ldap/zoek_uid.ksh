olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
trap "rm -f .test" 1 2 3 15
if [ ! -f .test ]
then
 echo -n "Password Directory Manager: "
 read -s passworddn
 umask 177
 echo -n $passworddn >.test
 ldapsearch -x -y .test -W -D "$olcRootDN" -b "uid=$1,ou=people,$olcSuffix" "(objectclass=*)"
else
 ldapsearch -x -y .test -W -D "$olcRootDN" -b "uid=$1,ou=people,$olcSuffix" "(objectclass=*)"
#ldapsearch -x -w $passworddn -D "$olcRootDN" -b "uid=$1,ou=people,$olcSuffix" "(objectclass=*)"
fi
