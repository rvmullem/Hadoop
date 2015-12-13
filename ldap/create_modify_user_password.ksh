cat >modfy_user_$1_password.ldif <<EOL
# entry for user for analyst group
dn: uid=$1,dc=hadoop,dc=$2,dc=$3,dc=local
changetype: modify
replace: userPassword
userPassword: $4

EOL
