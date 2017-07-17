#!/usr/bin/env bash

set -o nounset
set -o errexit

NORMAL=`echo "\033[m"`
YELLOW=`echo "\033[33m"`
GREEN=`echo "\033[32m"`
FGRED=`echo "\033[41m"`

BRANCH="master"

DAYS=${DAYS:-}
if [ ! -z ${DAYS} ]
    then DAYS=$DAYS
else 
    DAYS=14
fi

date --version > /dev/null 2>&1
if [ $? == 0 ]; then
    DATE=`date +%Y-%m-%d -d "-${DAYS}days"`
else
    DATE=`date -v-${DAYS}d +%Y-%m-%d`
fi

function printSubject
{
    echo -e "${YELLOW}$1:${NORMAL}"
}

function printDone 
{
    echo -e "${GREEN}done${NORMAL}"
    echo -e ""
}

echo -e ""
printSubject "Git Remote Branch Housekeeping"
echo -e ""

printSubject "Set conditions"
echo -e "- branch fully merged into ${BRANCH}"
echo -e "- commits older then $DAYS days (after ${DATE})"
printDone

printSubject "Fetch origin branches"
git fetch -p origin
printDone

printSubject "Branches"
BRANCHES=$(
    for k in `git branch -r --merged "$BRANCH" | perl -pe 's/^..(.*?)( ->.*)?$/\1/'`; do 
        echo -e `git log -1 --pretty=format:"%Cgreen%ci %Creset" --after="$DATE" $k -- | head -n 1`$k; 
    done | sort -r | grep '^origin' | sed 's/ *origin\///'
)
if [ "$BRANCHES" != "" ]; then
    echo -e "$BRANCHES"
    echo -e ""

    declare -i NUMBER_OF_BRANCHES=$(echo $BRANCHES | grep -o ' ' | wc -l)+1
    echo -e "${FGRED}Delete all ${NUMBER_OF_BRANCHES} branches${NORMAL} [y/n]: "

    read 
    if [ "$REPLY" == "y" ]; then
        echo $BRANCHES | xargs git push origin --delete 
        echo -e ""
        echo -e "branches are removed"
    fi

else
    echo -e "no remote branches"
fi

printDone
exit 0
