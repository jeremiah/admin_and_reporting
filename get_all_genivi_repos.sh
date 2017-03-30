#!bin/bash

# This is the GENIVI token that is created in the personal GitHub
# account under "settings."
TOKEN=

# Get all GENIVI repos. You must have a token to access the API which
# is also rate limited. Note also the pagination.
curl -H "Authorization: token $TOKEN" https://api.github.com/orgs/genivi/repos?per_page=100 -o foo
