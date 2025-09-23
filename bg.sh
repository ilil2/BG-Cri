if [ "$1" == "" ]; then
	me=$(whoami)
else
	me=$1
fi
link="https://cri.epita.fr/photos/thumb/$me"
cookie=$(curl -i -s -L https://cri.epita.fr/users/ | grep -i Set-Cookie | awk -F';' '{print $1}')
crfs=$($cookie | grep "crfs_token")
op=$($cookie | grep "op_browser_state" | head -n 1)
ids=$(nix-shell -p sqlite --command "sqlite3 ~/.mozilla/firefox/*.default/cookies.sqlite \"SELECT value FROM moz_cookies WHERE host='cri.epita.fr' AND name='sessionid'\"" | tail -n 1)

curl -b "crfs_token=$crfs; op_browser_state=$op; sessionid=$ids" -L $link | feh --bg-scale -
