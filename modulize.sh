#!/usr/bin/env bash

#grep $1 | tr ' ' \\n | sort | uniq | grep -e "^[A-Z].*"
find . -iname $1\* | xargs cat | tr ' ' \\n | sort | uniq | grep -e "^[A-Z].*\..*" | sed -e "s/\..*//" | sort | uniq | sed -e 's:.*:local & = require("&"):'
