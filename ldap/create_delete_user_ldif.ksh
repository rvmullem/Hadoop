usage ()
 {
 echo 'Usage : ./create_delete_user_ldif.ksh <User>'
 echo '  e.g.: ./create_delete_user_ldif.ksh janssen'
 exit
 }

if [ "$#" -ne 1 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

cat >delete_user_$1.ldif <<EOL
uid=$1,ou=people,$olcSuffix

EOL
