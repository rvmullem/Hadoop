usage ()
 {
 echo 'Usage : ./show_all_users.ksh'
 echo '  e.g.: ./show_all_users.ksh'
 exit
 }

if [ "$#" -ne 0 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

ldapsearch -x -y .test -W -D "$olcRootDN" -b "$olcSuffix" "(objectclass=*)"
