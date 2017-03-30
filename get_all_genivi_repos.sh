#!bin/bash

# This is the GENIVI token that is created in the personal GitHub
# account under "settings."
TOKEN=

# Get all GENIVI repos.
curl -H "Authorization: token $TOKEN" https://api.github.com/orgs/genivi/repos?per_page=100 -o foo
