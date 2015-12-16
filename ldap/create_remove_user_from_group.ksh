usage ()
 {
 echo 'Usage : ./create_remove_user_from_group.ksh <USER>'
 echo '  e.g.: ./create_remove_user_from_group.ksh janssen'
 exit
 }

if [ "$#" -ne 1 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'|sed -e 's/^[ \t]*//'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

cat >remove_user_$1_from_group.ldif <<EOL
# entry for user for analyst group
dn: cn=analyst,ou=groups,$olcSuffix
changetype: modify
delete: member
member: uid=$1,ou=people,$olcSuffix

EOL
