if [ "$1" == "" ]; then
	me=$(whoami)
else
	me=$1
fi
link="https://cri.epita.fr/photos/thumb/$me"
cookie=$(curl -i -s -L https://cri.epita.fr/users/ --negotiate | grep -i Set-Cookie | awk -F';' '{print $1}')
crfs=$(echo "$cookie" | grep "crfstoken" | head -n 1 | cut -d'=' -f2)
op=$(echo "$cookie" | grep "op_browser_state" | head -n 1 | cut -d'=' -f2)
ids=$(echo "$cookie" | grep "sessionid" | head -n 1 | cut -d'=' -f2)

curl -b "crfs_token=$crfs; op_browser_state=$op; sessionid=$ids" -L $link | feh --bg-scale -
