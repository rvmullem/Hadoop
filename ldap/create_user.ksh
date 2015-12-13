user=`echo $1|tr '[:upper:]' '[:lower:]'`
sudo ./zoek_uid.ksh $user $2 $3>/dev/null 2>&1
case $? in

0)  echo -e "\n user $user for $2, $3 already exist \n"
    exit
        ;;
32)     echo "user $user niet gevonden"
        ./create_add_user_ldif.ksh $user $2 $3 $4
        sudo ldapadd -x -y .test -W -D "cn=Manager,dc=hadoop,dc=$2,dc=$3,dc=local" -f add_user_$user.ldif
        ./create_add_user_to_group.ksh $user $2 $3
        sudo ldapmodify -x -y .test -W -D "cn=Manager,dc=hadoop,dc=$2,dc=$3,dc=local" -f add_user_$user\_to_group.ldif
        ;;

49) echo -e "\n wrong dc $2,$3 ?\n"
    exit
        ;;
*) echo "Unknown Error"
    exit
        ;;
esac
exit
