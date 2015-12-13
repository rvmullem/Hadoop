cat >delete_user_$1.ldif <<EOL
uid=$1,ou=people,dc=hadoop,dc=$2,dc=$3,dc=local

EOL
