usage ()
 {
 echo 'Usage : ./zoek_uid.ksh <User>'
 echo '  e.g.: ./zoek_uid.ksh janssen'
 exit
 }

if [ "$#" -ne 1 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

ldapsearch -x -y .test -W -D "$olcRootDN" -b "uid=$1,ou=people,$olcSuffix" "(objectclass=*)"
