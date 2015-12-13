ldapsearch -x -y .test -W -D "cn=Manager,dc=hadoop,dc=$1,dc=$2,dc=local" -b "dc=hadoop,dc=$1,dc=$2,dc=local" "(objectclass=*)"
