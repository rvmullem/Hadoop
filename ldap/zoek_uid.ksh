ldapsearch -x -y .test -W -D "cn=Manager,dc=hadoop,dc=$2,dc=$3,dc=local" -b "uid=$1,ou=people,dc=hadoop,dc=$2,dc=$3,dc=local" "(objectclass=*)"
