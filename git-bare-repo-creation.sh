#!/bin/bash

## Name: git-bare-repo-creation.sh
## Purpose: Create a directory, turn it into a bare git repo, stuff it with git history

# Path where our gits are kept
GIT_PATH=/foo/bar

# echo "Path: ${GIT_PATH}"  # debug

# Clone our repos (you'll need to create the repo.list.txt file if it doesn't exist)
# for FILE in $(<repo.list.txt)
# do mkdir ${GIT_PATH}${FILE%.git};
#    cd ${GIT_PATH}${FILE%.git} && git init --bare && touch git-daemon-export-ok && git update-server-info;
#    cd /root/
# done

# change the remotes, push
# for FILE in $(<repo.list.txt)
# do git clone ${GIT_PATH}${FILE};
#    cd ${FILE%.git};
#    if [ $? -eq 0 ]
#    then
#        echo "Remote origin for $(pwd)" $(git remote -v show);
#        echo " "
#        git remote rm origin;
#        git remote add origin ${GIT_PATH}${FILE%.git};
#        echo "After: " $(git remote -v show);
#        git push --all --force;
#        git push --tags;
#        cd /root/
#    else
#        echo "Failed to change directory."
#    fi
# done
#
