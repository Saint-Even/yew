#!/usr/bin/env bash
#strict mode
set -euo pipefail
IFS=$'\n\t'

#takes arg seconds, default 2
n=${1:-2}
echo "will self destruct in $n seconds"
sleep $n

echo "goodbye"
kill $$

...or exit 1 #throws error if the script fails due to my code
