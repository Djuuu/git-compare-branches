#!/bin/sh

BRANCH=$1
REFBRANCH=$2

################################################################################
# Functions
################################################################################

function usage
{
    echo "Usage : "
    echo "   git compare branches MY_BRANCH [REFERENCE_BRANCH]"
}

function check_branch
{
    if [[ `git branch | grep -w $1` ]]; then
        return 0 # Local branch
    fi
    if [[ `git branch -a | grep -w remotes/$1` ]]; then
        return 0 # Remote branch
    fi
    if [[ `git branch -a | grep -w remotes/origin/$1` ]]; then
        return 1 # Remote branch with no corresponding local branch
    fi

    echo "Branch $1 not found."
    exit 2
}

function fix_branch
{
    check_branch $1

    if [ $? == 1 ]; then
        echo "origin/$1"
        return 1;
    fi

    echo $1
    return 0;
}

function compare_branches
{
    local CMP_BRANCH=$(fix_branch $1)
    local CMP_REF_BR=$(fix_branch $2)

    local ref_cmd="git branch -a --merged ${CMP_REF_BR}"
    local ref_result=`${ref_cmd}`

    echo "Branches merged only in ${CMP_BRANCH} : "
    echo
    git branch -a --merged ${CMP_BRANCH} | grep -v "${ref_result}"
    echo
}

################################################################################
# Script
################################################################################

if [ ! $1 ] ; then
    # Current branch
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

if [ ! $2 ] ; then
    # Master as default reference branch
    REFBRANCH="master"
fi

check_branch $BRANCH
check_branch $REFBRANCH

echo "git branch -a --merged $BRANCH | grep -v \"\`git branch -a --merged $REFBRANCH\`\" (and vice-versa)"
echo

compare_branches "$BRANCH" $REFBRANCH
compare_branches "$REFBRANCH" $BRANCH
