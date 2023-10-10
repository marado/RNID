#!/bin/bash

## This script should only run the scripts that test things that cannot be
## automatically tested by Github Actions due to network restrictions.

if [ -e scripts/manual.sh ]; then
    ./scripts/52-covid.sh
else
    echo "Estás a correr isto a partir da directoria certa?"
fi
