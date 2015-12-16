usage ()
 {
 echo 'Usage : ./create_add_user_to_group.ksh <User>'
 echo '  e.g.: ./create_add_user_to_group.ksh janssen'
 exit
 }

if [ "$#" -ne 2 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

cat >add_user_$1_to_group.ldif <<EOL
# entry for user for analyst group
dn: cn=analyst,ou=groups,$olcSuffix
changetype: modify
add: member
member: uid=$1,ou=people,$olcSuffix

EOL
