usage ()
 {
 echo 'Usage : ./create_add_user_ldif.ksh <User> <Password>'
 echo '  e.g.: ./create_add_user_ldif.ksh bhr_mulle605 zomaarwat'
 exit
 }

if [ "$#" -ne 2 ]
then
  usage
fi

olcSuffix=`grep olcSuffix /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`
olcRootDN=`grep olcRootDN /etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif|awk -F: '{print $2}'`

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
if [ -f add_user_$1.ldif ]
then
  echo -e "\nFile add_user_$1.ldif already exists\n"
  mv add_user_$1.ldif add_user_$1.$current_time
fi
cat >add_user_$1.ldif <<EOL
# entry for user <username created in step 2>
dn: uid=$1,ou=people,$olcSuffix
objectclass:top
objectclass:person
objectclass:organizationalPerson
objectclass:inetOrgPerson
cn: $1
sn: $1
uid: $1
userPassword: $2

EOL
