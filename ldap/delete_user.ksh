usage ()
 {
 echo 'Usage : ./delete_user.ksh <User>'
 echo '  e.g.: ./delete_user.ksh janssen'
 exit
 }

if [ "$#" -ne 1 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

/home/bhr_mulle605/create_remove_user_from_group.ksh $1
ldapmodify -x -y /home/bhr_mulle605/.test -W -D "$olcRootDN" -f /home/bhr_mulle605/remove_user_$1_from_group.ldif
/home/bhr_mulle605/create_delete_user_ldif.ksh $1
ldapdelete -v -y /home/bhr_mulle605/.test -W -D "$olcRootDN" -f /home/bhr_mulle605/delete_user_$1.ldif
