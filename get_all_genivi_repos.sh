#!/bin/bash

# SPDX license identifier: MPL-2.0

# Copyright (C) 2017, Jeremiah C. Foster <jfoster@luxoft.com>

# This file is part of the GENIVI admin and reporting directory

# This Source Code Form is subject to the terms of the Mozilla Public
# License (MPL), v. 2.0.  If a copy of the MPL was not distributed with
# this file, You can obtain one at http://mozilla.org/MPL/2.0/.

# For further information see http://www.genivi.org/.

# This is the GENIVI token that is created in the personal GitHub
# account under "settings."
TOKEN=

# Get all GENIVI repos. You must have a token to access the API which
# is also rate limited. Note also the pagination.
curl -H "Authorization: token $TOKEN" https://api.github.com/orgs/genivi/repos?per_page=100 -o genivi-repos.json
