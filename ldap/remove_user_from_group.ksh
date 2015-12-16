usage ()
 {
 echo 'Usage : ./change_user_password.ksh <User>'
 echo '  e.g.: ./change_user_password.ksh janssen'
 exit
 }

if [ "$#" -ne 1 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

ldapmodify -x -y .test -W -D "$olcRootDN" -f $1
