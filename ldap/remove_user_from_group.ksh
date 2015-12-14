ldapmodify -x -y .test -W -D "cn=Manager,dc=hadoop,dc=$1,dc=$2,dc=local" -f $3
