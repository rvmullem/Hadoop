usage ()
 {
 echo 'Usage : ./change_user_password.ksh <User> <Password>'
 echo '  e.g.: ./change_user_password.ksh janssen zomaarwat'
 exit
 }

if [ "$#" -ne 2 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

./create_modify_user_password.ksh $1 $2
ldapmodify -x -y .test -W -D "$olcRootDN" -f ./modfy_user_$1_password.ldif
