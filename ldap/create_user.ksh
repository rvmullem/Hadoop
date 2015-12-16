usage ()
 {
 echo 'Usage : ./create_user.ksh <User> <Password>'
 echo '  e.g.: ./create_user.ksh janssen zomaarwat'
 exit
 }

if [ "$#" -ne 2 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

user=`echo $1|tr '[:upper:]' '[:lower:]'`
sudo /home/bhr_mulle605/zoek_uid.ksh $user >/dev/null 2>&1
case $? in

0)  echo -e "\n user $user already exist \n"
    exit
        ;;
32)     echo "user $user niet gevonden"
        /home/bhr_mulle605/create_add_user_ldif.ksh $user $2
        sudo ldapadd -x -y /home/bhr_mulle605/.test -W -D "$olcRootDN" -f /home/bhr_mulle605/add_user_$user.ldif
        /home/bhr_mulle605/create_add_user_to_group.ksh $user
        sudo ldapmodify -x -y /home/bhr_mulle605/.test -W -D "$olcRootDN" -f /home/bhr_mulle605/add_user_$user\_to_group.ldif
        ;;

49) echo -e "\n wrong dc ?\n"
    exit
        ;;
*) echo "Unknown Error"
    exit
        ;;
esac
exit

