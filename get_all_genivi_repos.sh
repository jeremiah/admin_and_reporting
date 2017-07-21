#!/bin/bash


# SPDX-license-identifier: MPL-2.0
# Copyright (C) 2017, Jeremiah C. Foster <jfoster@luxoft.com>
# This file is part of the GENIVI admin and reporting directory

# This Source Code Form is subject to the terms of the Mozilla Public
# License (MPL), v. 2.0.  If a copy of the MPL was not distributed with
# this file, You can obtain one at http://mozilla.org/MPL/2.0/.

# For further information see http://www.genivi.org/.

# The TOKEN var is the GENIVI token that is created in your GitHub
# account under "settings." 
TOKEN=

# Get all GENIVI repos. Note you must have the token for the api and the use of pagination.
# The -H flag is to send the authorization header
if curl --silent -H "Authorization: token $TOKEN" https://api.github.com/orgs/genivi/repos?per_page=100 -o genivi-repos.js; then
    # This is nasty, but there is just one "[" in the file
    # since it is a JS array so it shouldn't be a problem ;)
    # This ensures we have a proper JS array in the file declared as a var
    perl -pi'.bak' -e 's/\[/var repos = \[/' genivi-repos.js
else
    echo "Problem accessing the GitHub API."
fi
