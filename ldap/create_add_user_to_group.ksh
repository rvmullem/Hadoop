cat >add_user_$1_to_group.ldif <<EOL
# entry for user for analyst group
dn: cn=analyst,ou=groups,dc=hadoop,dc=$2,dc=$3,dc=local
changetype: modify
add: member
member: uid=$1,ou=people,dc=hadoop,dc=$2,dc=$3,dc=local

EOL
