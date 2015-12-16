usage ()
 {
 echo 'Usage : ./change_user_password.ksh <User> <Password>'
 echo '  e.g.: ./change_user_password.ksh bhr_mulle605 zomaarwat'
 exit
 }

if [ "$#" -ne 2 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

/home/bhr_mulle605/create_modify_user_password.ksh $1 $2
ldapmodify -x -y /home/bhr_mulle605/.test -W -D "$olcRootDN" -f /home/bhr_mulle605/modfy_user_$1_password.ldif
