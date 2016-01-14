olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

trap "rm -f .test" 0 1 2 3 15
if [ ! -f .test ]
then
 echo -n "Password Directory Manager: "
 read -s passworddn
 umask 177
 echo -n $passworddn >.test
fi

user=`echo $1|tr '[:upper:]' '[:lower:]'`
sudo ./zoek_uid.ksh $user >/dev/null 2>&1
case $? in
0)
  ./create_remove_user_from_group.ksh $1
  ldapmodify -x -y .test -W -D "$olcRootDN" -f remove_user_$1_from_group.ldif
  ./create_delete_user_ldif.ksh $1
  ldapdelete -v -y .test -W -D "$olcRootDN" -f delete_user_$1.ldif
  ;;
32) echo  -e "\n user $user does not exist \n"
  ;;
*) echo -e "\n Unknown Error \n"
 ;;

esac
exit
