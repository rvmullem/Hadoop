./create_remove_user_from_group.ksh $1 $2 $3
ldapmodify -x -y .test -W -D "cn=Manager,dc=hadoop,dc=$2,dc=$3,dc=local" -f remove_user_$1_from_group.ldif
./create_delete_user_ldif.ksh $1 $2 $3
ldapdelete -v -y .test -W -D "cn=Manager,dc=hadoop,dc=$2,dc=$3,dc=local" -f delete_user_$1.ldif
