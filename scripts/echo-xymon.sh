#!/bin/bash

# This script simply echoes whatever is read from stdin
while IFS= read -r line; do
    echo "$line"
done