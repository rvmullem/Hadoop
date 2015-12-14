# $0 <KDC Server> <domain> <serverlist>
scp $1:/home/beheer/keytab*.tar .
for server in `grep -v ^# ./$3`
do
 scp keytabs_$server.$2.tar $server:
done
savedir=keys-`date +"%d-%m-%Y:%H-%M"`
mkdir $savedir
for index in `ls keytabs*.tar|grep -v a01`
do
 echo $index
 mv $index $savedir/
done
