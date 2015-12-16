usage ()
 {
 echo 'Usage : ./create_modify_user_password.ksh <User> <New Password>'
 echo '  e.g.: ./create_modify_user_password.ksh janssen zomaarwat'
 exit
 }

if [ "$#" -ne 2 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

cat >modfy_user_$1_password.ldif <<EOL
# entry for user for analyst group
dn: uid=$1,ou=people,$olcSuffix
changetype: modify
replace: userPassword
userPassword: $2

EOL
