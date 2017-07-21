#!/usr/bin/env bash

set -o nounset
set -o errexit

NORMAL=`echo "\033[m"`
BOLD=`echo "\033[1m"`
YELLOW=`echo "\033[33m"`
GREEN=`echo "\033[32m"`
FGRED=`echo "\033[41m"`


function printSubject
{
    echo -e "${YELLOW}$1${NORMAL}"
}

function printDone 
{
    echo -e "${GREEN}done${NORMAL}"
    echo -e ""
}

function printConditions
{
    echo -e "- branch fully merged into ${REMOTE_REPO} ${BRANCH}"
    echo -e "- commits older then $DAYS days (after ${DATE})"
    printDone
}

function checkUpstream
{
    git fetch --quiet --prune $REMOTE_REPO

    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$UPSTREAM")
    BASE=$(git merge-base @ "$UPSTREAM")

    if [ $LOCAL = $REMOTE ]; then
        echo "up to date"
    elif [ $LOCAL = $BASE ]; then
        echo "need to pull"
    elif [ $REMOTE = $BASE ]; then
        echo "need to push"
    else
        echo "diverged"
    fi

    printDone
}

function printCheckGitRepo
{
    git rev-parse --is-inside-work-tree > /dev/null
}

function deleteRemoteBranches
{
    BRANCHES=$(
        for k in `git branch -r --merged "$BRANCH" | perl -pe 's/^..(.*?)( ->.*)?$/\1/'`; do 
            echo -e `git log -1 --pretty=format:"%Cgreen%ci %Creset" --after="$DATE" $k -- | head -n 1`$k; 
        done | sort -r | grep "^$REMOTE_REPO" | sed "s/ *$REMOTE_REPO\///"
    )
    if [ "$BRANCHES" != "" ]; then
        echo -e "$BRANCHES"
        echo -e ""

        if [ "$1" -eq "0" ]; then
            declare -i NUMBER_OF_BRANCHES=$(echo $BRANCHES | grep -o ' ' | wc -l)+1
            echo -e "${FGRED}Are you sure you want to delete these ${BOLD}${NUMBER_OF_BRANCHES}${NORMAL}${FGRED} branches${NORMAL} [y/n]: "
            read 
        else 
            REPLY="y"
        fi

        if [ "$REPLY" == "y" ]; then
            echo $BRANCHES | xargs git push $REMOTE_REPO --delete --quiet
            echo -e "branches are removed"
	else
	    echo -e ""
        fi

    else
        echo -e "no remote branches"
    fi
}

function printTitle
{
    echo -e ""
    printSubject "Git Remote Branch Housekeeping"
    echo -e ""
}

function printHelp
{
    echo -e "usage:
remote-branch-housekeeping [ -f | -r | -d | -b ]

-d <number>, --days <number>
Defines days, default 14.

-b <master>, --branch <master>
Branch name, default \"master\".

-r <origin>, --remote <origin>
Remote name, default \"origin\".

-f, --force
Don't ask for confirm to delete branches.
"
}

FORCE=0
DAYS=14
BRANCH="master"
REMOTE_REPO="origin"
while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
        -f|--force)
            FORCE=1
        ;;

        -r|--remote)
            shift 
            REMOTE_REPO="$1"
        ;;

        -b|--branch)
            shift 
            BRANCH="$1"
        ;;

        -d|--days)
            shift 
            DAYS="$1"
        ;;

        *)
            printTitle
            printHelp
            exit 0
        ;;
    esac
    shift
done

date --version > /dev/null 2>&1
if [ $? == 0 ]; then
    DATE=`date +%Y-%m-%d -d "-${DAYS}days"`
else
    DATE=`date -v-${DAYS}d +%Y-%m-%d`
fi

printTitle
printCheckGitRepo

printSubject "Conditions"
printConditions

printSubject "Fetching branches..."
checkUpstream

printSubject "Deleting branches..."
deleteRemoteBranches $FORCE

printDone
exit 0

