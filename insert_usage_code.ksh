sed -i "1i usage () 
\n {\n echo 'Usage : ./start_test_2.4.2_clean_directories.ksh <FQDN KNOX SERVER> <USER>'
\n  echo '      e.g: ./start_test_clean_directories.ks node1.zomaarwat.nl account'
\n exit\n }
\n
\n
if [ \"\$\#\" -ne 2 ]\n
  then\n  usage\n
 fi\n" test_2.4.2* # for all test scripts
 
