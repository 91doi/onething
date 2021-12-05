#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for bgoldd"

  set -- bgoldd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "bgoldd" ]; then
 