set -o vi
randpw(){ < /dev/urandom tr -dc A-Za-z0-9 | head -c${1:-20};echo;}
super_randpw(){ </dev/urandom tr -dc '1234567890!@#$%^&*()[]|{}\;:<>,./qwertyuiopQWERTYUIOPasdfghjklASDFGHJKLzxcvbnmZXCVBNM' | head -c20; echo "";}
function proml ()
{
case $TERM in
    xterm*)
        local TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        local TITLEBAR=''
        ;;
esac

PS1="${TITLEBAR}\
[\$(date +%H:%M)]\
[\u@\h:\w]\
\$ "
PS2='> '
PS4='+ '
}

proml
