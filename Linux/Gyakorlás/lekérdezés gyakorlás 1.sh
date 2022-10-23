
CURRENTNAME=$(whoami)
GROUP=$(cat /etc/group | grep $CURRENTNAME | cut -f1 -d":")
PLACE=$(cat /etc/passwd | grep $CURRENTNAME | cut -f6 -d":")
MAPS=$(find / -user $CURRENTNAME -type d 2> /dev/null)

echo -e "The current user is: $CURRENTNAME\n"
echo -e "\nUsers groups are: \n$GROUP\n"
echo -e "\nHome path: $PLACE\n"
echo -e "\nMappák: $MAPS"

#vagy kettőspont megfadással zárójelek nélkül pl :
echo -e "Felhasznalónév \c " ; whoami
#vagy devnull helyett így elkerülni a permission denied mappák listázását
#MAPS=$(find / -user $CURRENTNAME -type d -perm /7)