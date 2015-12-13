# sudo $0
ldapsearch -x -y .test -W -D "cn=Manager,dc=hadoop,dc=$1,dc=$2,dc=local" -b "cn=analyst,ou=groups,dc=hadoop,dc=$1,dc=$2,dc=local" "(objectclass=*)"
