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

0)  echo -e "\n user $user already exist \n"
        ;;
32)     echo "user $user niet gevonden"
        ./create_add_user_ldif.ksh $user $2
        sudo ldapadd -x -y .test -W -D "$olcRootDN" -f add_user_$user.ldif
        echo -e "\n"
        grep userPassword  add_user_$user.ldif
        echo -e "\n"
        ./create_add_user_to_group.ksh $user
        sudo ldapmodify -x -y .test -W -D "$olcRootDN" -f add_user_$user\_to_group.ldif
        ;;

49) echo -e "\n wrong dc ?\n"
        ;;
*) echo "Unknown Error"
        ;;
esac
exit
