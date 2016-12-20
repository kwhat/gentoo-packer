#!/bin/bash

if [[ -z $STAGE4 ]]
then
  echo "STAGE4 environment variable must be set to an iso file."
  exit 1
fi

if [[ -z $BASEDIR ]]
then
  BASEDIR=.
fi

#$BASEDIR/scripts/stage4/*.sh \
for script in $BASEDIR/scripts/stage3/*.sh \
  $BASEDIR/scripts/cleanup.sh
do
  echo "$script"
  chmod +x "$script" && "$script"
done

echo "All done."
