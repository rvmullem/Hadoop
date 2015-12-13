current_time=$(date "+%Y.%m.%d-%H.%M.%S")
if [ -f add_user_$1.ldif ]
then
  echo -e "\nFile add_user_$1.ldif already exists\n"
  mv add_user_$1.ldif add_user_$1.$current_time
fi
cat >add_user_$1.ldif <<EOL
# entry for user <username created in step 2>
dn: uid=$1,ou=people,dc=hadoop,dc=$2,dc=$3,dc=local
objectclass:top
objectclass:person
objectclass:organizationalPerson
objectclass:inetOrgPerson
cn: $1
sn: $1
uid: $1
userPassword: $4

EOL
