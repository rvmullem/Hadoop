# vraagt om LDAP directory manager password
usage ()
 {
 echo 'Usage : sudo ./wie_zit_in_de_analyst_group'
 echo '  e.g.: sudo ./wie_zit_in_de_analyst_group'
 exit
 }

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
trap "rm -f .test" 0 1 2 3 15
echo -n "Password Directory Manager: "
read -s passworddn
umask 177
echo -n $passworddn >.test

ldapsearch -x -y .test -W -D "$olcRootDN" -b "cn=analyst,ou=groups,$olcSuffix" "(objectclass=*)"
