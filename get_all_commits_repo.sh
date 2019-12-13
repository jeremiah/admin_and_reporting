#!/bin/bash 

## Version 0.2

# SPDX-license-identifier: MPL-2.0
# Copyright (C) 2017, Jeremiah C. Foster <jfoster@luxoft.com>
# Copyright (C) 2017, The GENIVI Alliance
# This file is part of the GENIVI admin and reporting directory

# This Source Code Form is subject to the terms of the Mozilla Public
# License (MPL), v. 2.0.  If a copy of the MPL was not distributed with
# this file, You can obtain one at http://mozilla.org/MPL/2.0/.

# For further information see http://www.genivi.org/.
###

# The TOKEN comes from GitHub. Use it with the -H flag in curl
TOKEN=$(<TOKEN)
COMMITS="/var/www/html/kpi/committers.by.email.txt"

# A list of repositories we want commiters from
for REPO in $(<GH-genivi-proj-names.txt) # GH-genivi-proj-names.txt
do
    echo "Checking ${REPO}"
    # set -x
    
    # curl --silent  -H "Authorization: token $TOKEN" "https://api.github.com/repos/genivi/${REPO}/commits?since=2017-01-01T00:00:00Z&per_page=100" | \
    # jq '.[] | {message: .commit.message, commiter: .commit.committer.name, email: .commit.committer.email, author: .commit.author.name, date: .commit.author.date}' >> temp.committers.json
    # [ -d ${REPO} ] || mkdir ${REPO}
    # cd ${REPO};
    # echo $( pwd );
    
    echo "Getting pages for ${REPO}"
    # Get commits since
    # first, we have to manage pagination from GH's API as well as negotiate rate limiting
    LASTSTRING=$( curl --silent -I -H "Authorization: token $TOKEN" https://api.github.com/repos/genivi/${REPO}/commits?since="2018-01-01T00:00:00Z" | grep "\"last" )
    LASTPAGE=$( echo $LASTSTRING | awk -F"page=" '{print $3}' )

    echo "Last string: ${LASTSTRING}"
    echo "Last page: ${LASTPAGE}"
    echo "repo ${REPO}" >> temp.committers.json
    
    if [[ ${LASTPAGE%%>*} =~ [[:digit:]] ]]
    then
	curl --silent  -H "Authorization: token $TOKEN" "https://api.github.com/repos/genivi/${REPO}/commits?since=2018-01-01T00:00:00Z&page=[1-${LASTPAGE%%>*}]" | \
	    jq '.[] | {message: .commit.message, commiter: .commit.committer.name, email: .commit.author.email, author: .commit.author.name, date: .commit.author.date}' >> temp.committers.json
    else
	curl --silent  -H "Authorization: token $TOKEN" "https://api.github.com/repos/genivi/${REPO}/commits?since=2018-01-01T00:00:00Z&per_page=100" | \
	    jq '.[] | {message: .commit.message, commiter: .commit.committer.name, email: .commit.author.email, author: .commit.author.name, date: .commit.author.date}' >> temp.committers.json
    fi
done

# Let's munge in temp files
TMP=$( mktemp /tmp/temporary.XXXXXX )
COMMITS="/var/www/html/kpi/committers/committers.by.email.txt".$( date +%s )

# Let's munge in temp files
grep email /var/www/html/kpi/temp.committers.json | sort | uniq -c > ${TMP}
sort -nr ${TMP} | sed -e 's/\   "email\":/,/g' -e 's/\"//g' > ${COMMITS}

grep author /var/www/html/kpi/temp.committers.json | sort | uniq -c > ${TMP} 
sort -nr ${TMP} | sed 's/\   "author\":/,/g' >> ${COMMITS}

# let's make some html - note that this appends to the 2018 page!
awk -F"," '{ print "<li><b>"$1"</b> &nbsp; "$2"</li>" }' ${COMMITS} >> /var/www/html/kpi/2018_committers.html
