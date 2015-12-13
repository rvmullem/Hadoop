./create_modify_user_password.ksh $1 $2 $3 $4
ldapmodify -x -y .test -W -D "cn=Manager,dc=hadoop,dc=$2,dc=$3,dc=local" -f ./modfy_user_$1_password.ldif
