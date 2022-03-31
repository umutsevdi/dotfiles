#! /bin/bash
# Displays the amount of active docker containers with their id's and image names
count=$(docker ps -q | wc -l | sed -r 's/^0$//g')
if (( count > 0 ));
then
    data=$(docker ps | awk 'NR>1' | awk '{ print $2 }'  | tr '\n' '|')
    echo "    ${data::-1} ($count)"
else 
    echo
fi
