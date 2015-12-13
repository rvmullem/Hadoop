cat >remove_user_$1_from_group.ldif <<EOL
# entry for user for analyst group
dn: cn=analyst,ou=groups,dc=hadoop,dc=$2,dc=$3,dc=local
changetype: modify
delete: member
member: uid=$1,ou=people,dc=hadoop,dc=$2,dc=$3,dc=local

EOL
